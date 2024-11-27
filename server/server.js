import express from "express";
import path from "path";
import homepageRouter from "./homepageRouter.js";
import assetsRouter from "./assetsRouter.js";
import {createServer} from "http";
import {Server} from "socket.io";
import { db, secret } from "./config.mjs";
import bcrypt from "bcrypt";
import bodyParser from "body-parser";
import session from "express-session";
import os from "os";
import cors from "cors";

const port = process.env.PORT || 3000;
const publicPath = path.join(path.resolve(), "public");
const distPath = path.join(path.resolve(), "dist");

const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer, {
    cors: {
        origin: [
            "*" // Pour autoriser toutes les connexions
        ],
        methods: ["GET", "POST"]
    }
});


const sessionMiddleware = session({ // Middleware pour la session
    secret: secret,
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }
});

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true })); // Pour parser les données POST
app.use(sessionMiddleware); // Utilisation du middleware pour la session express

// Fonction pour récupérer l'adresse IP local
function getLocalIpAddress() {
    const interfaces = os.networkInterfaces();
    for (const name of Object.keys(interfaces)) {
        for (const iface of interfaces[name]) {
            if (iface.family === 'IPv4' && !iface.internal && !name.includes('VMware') && !name.includes('vEthernet')) {
                return iface.address;
            }
        }
    }
    return '0.0.0.0';
}


//
// Routes pour l'inscription, la connexion et la déconnexion des utilisateurs
//

// Route pour l'inscription des utilisateurs
app.post("/api/user/register", async (req, res) => {
    const { email, username, password } = req.body;
    if (!email || !username || !password) {
        return res.status(400).json({ message: "Tous les champs sont requis" });
    }
    // Test de l'unicité de l'email et du nom d'utilisateur
    const [email_rows] = await db.query("SELECT id FROM utilisateurs WHERE email = ?", [email]);
    const [username_rows] = await db.query("SELECT id FROM utilisateurs WHERE username = ?", [username]);
    if (email_rows.length > 0) {
        return res.status(400).json({ message: "Email déjà utilisé" });
    }
    if (username_rows.length > 0) {
        return res.status(400).json({ message: "Nom d'utilisateur déjà utilisé" });
    }
    try {
        // Hachage du mot de passe
        const hashedPassword = await bcrypt.hash(password, 10);
        const query = 'INSERT INTO utilisateurs (email, username, password) VALUES (?, ?, ?)';
        // Création de l'utilisateur et insertion dans la base de données
        await db.query(query, [email, username, hashedPassword]);

        const [rows] = await db.query('SELECT id FROM utilisateurs WHERE username = ?', [username]);
        if (rows.length > 0) {
            const user_id = rows[0].id; // Assigne l'ID à l'utilisateur
            console.log('Utilisateur inscrit avec l\'ID : ' + user_id);
            res.status(201).json({ message: 'Inscription réussie', user_id });
        } else {
            res.status(500).json({ message: 'Erreur lors de la récupération de l\'ID de l\'utilisateur' });
        }
    } catch (error) {
         console.log('Erreur lors de l\'inscription :' + error);
        res.status(500).json({ message: 'Erreur lors de l\'inscription' });
    }
});

// Route pour la connexion des utilisateurs
app.post("/api/user/login", async (req, res) => {
    const { username, password } = req.body;
    try {
        const query = 'SELECT * FROM utilisateurs WHERE username = ?';
        const [rows] = await db.query(query, [username]);
        // Vérification de l'existence de l'utilisateur
        if (rows.length === 0) {
            return res.json({ success: false, message: 'Nom d\'utilisateur non trouvé' });
        }

        const user = rows[0];
        // Vérification du mot de passe
        const match = await bcrypt.compare(password, user.password);
        if (!match) {
            console.log('Mot de passe incorrect pour l\'utilisateur :' + user.id);
            return res.json({ success: false, message: 'Mot de passe incorrect' });
        }
        
        console.log('Connexion réussie pour l\'utilisateur :' + user.id);
        console.log('Avec l\'ID de session : ' + req.session.id);
        req.session.name = user.name
        res.json({ success: true, message: 'Connexion réussie' });
        
        session.count = (session.count || 0) + 1;
        res.status(200).end("" + session.count);
        console.log('Nombre de connexions : ' + session.count);

        io.to(session.id).emit("nb_session", session.count);
    } catch (error) {
        console.log('Erreur lors de la connexion :' + error);
        res.status(500).json({ message: 'Erreur lors de la connexion' });
    }
});

//
// Route pour la déconnexion des utilisateurs
//

app.post("/api/user/logout", (req, res) => {
    console.log('Requête de déconnexion de l\'utilisateur :' + req.session.id);
    const idLogout = req.session.id;
    req.session.destroy((err) => {
        if (err) {
            return res.status(500).json({message: 'Erreur lors de la déconnexion'});
        }
        io.in(idLogout).disconnectSockets();
        res.json({success: true, message: 'Déconnexion réussie pour l\'utilisateur :' + idLogout});
        res.status(204).end();
        console.log('Déconnexion réussie pour l\'utilisateur :' + idLogout);
    });
});

//
// Route pour les interactions avec l'utilisateur
//

// Route pour récupérer les informations de l'utilisateur
app.get("/api/user/session", async (req, res) => {
    if (req.session.id) {
        return res.json({success: true, isLoggedIn: true});
    } else {
        res.status(401).json({success: false, isLoggedIn: false, message: 'Non autorisé'});
    }
});

// changement de la variable d'env pour la production
if (process.env.NODE_ENV === "production") {
    app.use("/", express.static(distPath));
} else {
    app.use("/", express.static(publicPath));
    app.use("/src", assetsRouter);
}

app.use(homepageRouter);

//
// Interactions avec les salons de discussion
//

io.engine.use(sessionMiddleware); // Utilisation du middleware pour le socket

io.on('connection', (socket) => {
    console.log('Socket connecté : ' + socket.request.session.id);
    
    socket.on('send_message', (data) => {
        io.emit('new_message', data);
    });

    socket.on('disconnect', () => {
        const idDisconnect = socket.request.session.id;
        io.in(idDisconnect).disconnectSockets();
        console.log('Socket déconnecté');
    });
});
    
httpServer.listen(port, '0.0.0.0', () => {
    console.log(`server ouvert sur http://localhost:${port}\n`);
    console.log(`en local sur http://`+ getLocalIpAddress() + `:${port}`);
});


