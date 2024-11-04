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
import sharedSession from "express-socket.io-session";


const publicPath = path.join(path.resolve(), "public");
const port = process.env.PORT || 3000;
const app = express();
const server = createServer(app);
const io = new Server(server);

const sessionMiddleware = session({
    secret: secret,
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(sessionMiddleware);


//---------------------------------------------------------//
// Routes pour l'inscription et la connexion et la déconnexion des utilisateurs
//---------------------------------------------------------//

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
            const userId = rows[0].id; // Assigne l'ID à l'utilisateur
            console.log('Utilisateur inscrit avec l\'ID : ' + userId);
            res.status(201).json({ message: 'Inscription réussie', userId });
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
        req.session.userId = user.id;
        req.session.userName = user.name
        console.log('Connexion réussie pour l\'utilisateur :' + user.id);
        res.json({ success: true, message: 'Connexion réussie' });
    } catch (error) {
        console.log('Erreur lors de la connexion :' + error);
        res.status(500).json({ message: 'Erreur lors de la connexion' });
    }
});

// Route pour la déconnexion des utilisateurs
app.post("/api/user/logout", (req, res) => {
    console.log('Requête de déconnexion de l\'utilisateur :' + req.session.userId);
    const idLogout = req.session.userId;
    req.session.destroy((err) => {
        if (err) {
            return res.status(500).json({message: 'Erreur lors de la déconnexion'});
        }
        res.json({success: true, message: 'Déconnexion réussie pour l\'utilisateur :' + idLogout});
        console.log('Déconnexion réussie pour l\'utilisateur :' + idLogout);
    });
});

//
// Route pour les interactions avec l'utilisateur
//

// Route pour récupérer les informations de l'utilisateur
app.get("/api/user/session", async (req, res) => {
    if (req.session.userId) {
        return res.json({success: true, isLoggedIn: true});
    } else {
        res.status(401).json({success: false, isLoggedIn: false, message: 'Non autorisé'});
    }
});


app.use("/", express.static(publicPath));
app.use("/src", assetsRouter);
app.use(homepageRouter);

//
// Interactions avec les salons de discussion
//

io.use(sharedSession(sessionMiddleware, {
    autoSave: true
}));

io.on('connection', (socket) => {
    if (!socket.handshake.session.userId) {
        console.log('Connexion refusée : utilisateur non authentifié');
        socket.disconnect();
        return;
    }
    
    console.log('Socket connecté : ' + socket.handshake.session.userId);
    socket.on('chat message', (msg) => {
        console.log('Message reçu : ' + msg);
        io.emit('chat message', msg);
    });
    
    socket.on('disconnect', () => {
        console.log('Socket déconnecté : ' + socket.handshake.session.userId);
    });
});


server.listen(port, () => {
    console.log(`server ouvert sur http://localhost:${port}`);
});


