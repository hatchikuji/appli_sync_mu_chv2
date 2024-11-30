<template>
  <div id="app">
    <header>
      <!-- Affiche la navbar, le nom d'utilisateur et les différentes options s'il est connecté -->
      <div v-if="isLoggedIn">
        <nav class="navbar">
          <ul class="navlist">
            <li class="navli">
              <router-link to="/">Accueil</router-link>
            </li>
            <li class="navli">
              <router-link to="/artistes">Artistes</router-link>
            </li>
            <li class="navli">
              <router-link to="/titres">Titres</router-link>
            </li>
            <li class="navli">
              <router-link to="/profil">Profil</router-link>
            </li>
            <li class="navli">
              <div class="searchbox">
                <input type="text" v-model="searchQuery" @input="optimizedHandleSearch"
                       placeholder="Titre, Album, Nom d'artiste...">
              </div>
            </li>
          </ul>
        </nav>
        <!-- Boutton pour ouvrir le chat -->
        <button @click="toggleDrawer" class="drawer-toggle">
          {{ isDrawerOpen ? "Fermer le chat" : "Ouvrir le chat" }}
        </button>
      </div>
    </header>
    <main>
      <div v-if="isLoggedIn">
        <!-- Tiroir pour le chat -->
        <div class="drawer" :class="{ open: isDrawerOpen}">
          <h2 class="chat-title">Chat</h2>
          <div class="messages">
            <div v-for="(data, index) in messages" :key="index" class="message">
              {{ data.user_name }}: {{ data.text }}
            </div>
          </div>
          <input v-model="newMessage" @keyup.enter="sendMessage" placeholder="Entrez votre message..."/>
          <button @click="sendMessage">Envoyer</button>
        </div>
        <ul v-if="results && results.length" class="resultgrid">
          <li v-for="(result, index) in results" :key="index" class="resultlist">
            <div class="titre_artiste">
              <p><strong>{{ result.titre }}</strong></p>
              <p>{{ result.nom_artiste }}</p>
            </div>
            <div class="album">
              {{ result.album || "Non spécifié" }}
            </div>
            <div class="duree">
              {{ formatDuration(result.duree) }}
            </div>
          </li>
        </ul>
        <div v-else-if="searchQuery && !errorMessage">
          <p>Aucun résultat trouvé pour "{{ searchQuery }}"</p>
        </div>

        <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
      </div>
      <!-- Formulaire de connexion/inscription -->
      <div class="logreg-form">
        <LoginForm v-if="!isLoggedIn && showLoginForm" @login="handleLogin"/>
        <RegisterForm v-if="!isLoggedIn && !showLoginForm"/>
        <button v-if="!isLoggedIn" @click="toggleForm">{{ showLoginForm ? "S'inscrire" : "Se connecter" }}</button>
        <button v-if="isLoggedIn" @click="handleLogout">Déconnexion</button>
      </div>
    </main>
  </div>
</template>

<script>
import LoginForm from "./components/LoginForm.vue";
import RegisterForm from "./components/RegisterForm.vue";
import eventBus from "./eventBus.js";
import {io} from "socket.io-client";

export default {
  name: "App",
  components: {
    LoginForm,
    RegisterForm
  },
  data() {
    return {
      isLoggedIn: false, // État de connexion
      showLoginForm: true, // Affiche le formulaire de connexion
      newMessage: "", // Nouveau message
      messages: [], // Liste des messages
      user_name: null, // Initialiser avec `null` pour indiquer qu'il est en cours de chargement
      socket: null, // Instance de socket.io
      isDrawerOpen: false, // État du chat
      searchQuery: "", // Recherche de titre, album ou artiste
      errorMessage: "",
      results: [], // Résultats de la recherche
    };
  },
  methods: {
    async handleSearch() { // Redirige l'utilisateur vers la page de recherche avec la requête de recherche
      try {
        const response = await fetch(`/api/search?query=${this.searchQuery}`, {
          method: "GET",
          credentials: "include"
        });
        this.errorMessage = ""; // Réinitialise le message d'erreur
        if (!response.ok) {
          // noinspection ExceptionCaughtLocallyJS
          throw new Error("Erreur lors de la recherche");
        }

        if (!this.searchQuery.trim()) {
          this.results = []; // Réinitialise les résultats
          return;
        }

        const data = await response.json();
        if (data.success) {
          this.results = data.results[0] // Mets à jour les résultats de la recherche
          console.log("Résultats de la recherche:", this.results);
        } else {
          console.error("Erreur:", data.message);
          this.results = null;
        }
      } catch (error) {
        this.errorMessage = "Une erreur est survenue lors de la recherche.";
        console.error("Erreur lors de la recherche:", error);
        this.results = null;
      }
    },
    formatDuration(ms) {
      const totalSeconds = Math.floor(ms / 1000);
      const minutes = Math.floor(totalSeconds / 60);
      const seconds = totalSeconds % 60;
      const formattedSeconds = seconds < 10 ? `0${seconds}` : seconds;
      return `${minutes}:${formattedSeconds}`;
    },
    debounce(callback, delay) {
      let timer;
      return function (...args) {
        clearTimeout(timer);
        timer = setTimeout(() => {
          callback.apply(this, args);
        }, delay);
      };
    },
    toggleForm() {
      // Inverse la valeur de showLoginForm pour afficher le formulaire d'inscription
      this.showLoginForm = !this.showLoginForm;
    },
    toggleDrawer() {
      this.isDrawerOpen = !this.isDrawerOpen; // Ouvre/ferme le chat
    },
    handleLogin({username}) {
      this.isLoggedIn = true; // Connecte l'utilisateur
      this.user_name = username; // Récupère le nom d'utilisateur
      this.socket = io("http://localhost:3000", {
        withCredentials: true,
        extraHeaders: {
          "login-message-header": "login and message"
        }
      }); // Connexion au serveur socket.io
      this.socket.on("new_message", (data) => {
        this.messages.push(data);
      });
    },
    async handleLogout() {
      try {
        await fetch("/api/user/logout", {
              method: "POST",
              credentials: "include"
            },
        ); // Déconnecte le socket
        this.isLoggedIn = false; // Déconnecte l'utilisateur
      } catch (error) {
        console.error("Erreur lors de la déconnexion:", error);
      }
    },
    sendMessage() {
      if (this.user_name && this.newMessage) {
        const data = {
          user_name: this.user_name,
          text: this.newMessage,
        };
        this.socket.emit("send_message", data);
        console.log("Message envoyé au serveur: ", data);
        this.newMessage = ""; // Réinitialise le champ de saisie
      } else {
        console.error("Impossible d'envoyer le message: nom d'utilisateur ou message manquant");
      }
    }
  },
  mounted() {
    eventBus.on("login", ({userId, username}) => {
      this.handleLogin({userId, username});
    });
    this.optimizedHandleSearch = this.debounce(this.handleSearch, 300);
  },
};
</script>
<style scoped>
/* Styles pour le bouton du tiroir */
.drawer-toggle {
  position: absolute;
  right: 2%;
  bottom: 2%;
  cursor: pointer;
  z-index: 1001;
}

/* Styles pour le tiroir */
.drawer {
  position: fixed;
  top: 0;
  right: -300px;
  width: 300px;
  height: 100%;
  background-color: #000000;
  box-shadow: -2px 0 5px rgba(0, 0, 0, 0.3);
  transition: right 0.3s ease-in-out;
  overflow: hidden;
  z-index: 1000;
}

.drawer.open {
  right: 0;
}

.chat-title {
  text-align: left;
  padding-left: 10%;
}

.messages {
  flex-grow: 1;
  overflow-y: auto;
  overflow-x: hidden;
  margin-bottom: 10px;
  max-height: 70vh;
  padding: 5px;
  text-align: left;
  background-color: #000000;
  word-wrap: break-word;
}

input {
  padding: 5px;
  border: 1px solid #ffffff;
  border-radius: 4px;
}

button {
  margin-top: 10px;
  padding: 10px;
  background-color: #6200ea;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

/* Navbar style */
.navli {
  list-style: none;
  height: 100%;
  align-content: center;
}

.navbar {
  background-color: #000000;
  display: flex;
  z-index: 1000;
  position: sticky;
  top: 0;
  width: auto;
}

.navbar .navlist {
  list-style-type: none;
  padding: 0;
  margin: 0;
}

.navbar .navlist li {
  float: left;
}

.navbar .navlist li a {
  display: block;
  color: #ffffff;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  transition: background-color 0.3s ease-in, color 0.3s ease-in;
}

.navbar .navlist li a:hover {
  background-color: #8243AE;
  color: #000000;
  text-decoration: underline;
}

/* Styles pour l'affichage de la bare de recherche de musique */

.searchbox {
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  margin: 0;
}

/* Styles pour les résultats de la recherche */

.error-message {
  color: red;
  margin: 10px 0;
}

.resultgrid {
  display: grid;
  gap: 10px;

}

.resultlist {
  list-style: none;
  border: solid #ffffff;
  width: 70vw;
  display: flex;
  align-items: center;
}

.titre_artiste {
  flex: 1;
  margin-left: 2%;
}

.album {
  flex: 1;
  text-align: left;
}

.duree {
  flex: 1;
  text-align: left;
}
</style>