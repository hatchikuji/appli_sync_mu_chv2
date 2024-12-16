<template>
  <div id="app" class="container">
    <header>
      <!-- Affiche la navbar, le nom d'utilisateur et les différentes options s'il est connecté -->
      <div v-if="isLoggedIn">
        <nav class="navbar">
          <ul class="navlist">
            <li>
              <div class="searchbox">
                <button @click="handleLogout">Déconnexion</button>
              </div>
            </li>
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
        <!-- Affiche les résultats de la recherche -->
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
            <div>
              <div v-if="!currentSong">
                <button @click="playsound(result.chemin)">Jouer</button>
              </div>
              <div v-else>
                <button @click="playsound(result.chemin)">Pause</button>
              </div>
            </div>
          </li>
        </ul>
        <div v-else-if="searchQuery && !errorMessage">
          <p>Aucun résultat trouvé pour "{{ searchQuery }}"</p>
        </div>

        <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
      </div>
      <!-- Formulaire de connexion/inscription -->
      <div class="form-group">
        <h2 v-if="!isLoggedIn">Connexion</h2>
        <LoginForm v-if="!isLoggedIn && showLoginForm" @login="handleLogin"/>
        <RegisterForm v-if="!isLoggedIn && !showLoginForm"/>
        <button class="btn-primary" v-if="!isLoggedIn" @click="toggleForm">{{ showLoginForm ? "S'inscrire" : "Se connecter" }}</button>
      </div>
    </main>
    <footer v-if="isLoggedIn">
      <!-- Boutton pour ouvrir le chat -->
      <button @click="toggleDrawer" class="drawer-toggle">
        {{ isDrawerOpen ? "Fermer le chat" : "Ouvrir le chat" }}
      </button>
    </footer>
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
      errorMessage: "", // Message d'erreur
      results: [], // Résultats de la recherche
      currentSong: null, // Chanson en cours de lecture
      search:  false // Recherche par défaut
    };
  },
  methods: {
    playsound(path) {
      if (path && !this.currentSong) {
        this.currentSong = new Audio(path);
        return this.currentSong.play();
        } else if (this.currentSong) {
          this.currentSong.pause()
          return this.currentSong = null;
      } else {
        console.error("Impossible de lire le fichier audio: chemin manquant");
      }
    },
    async handleSearch() { // Redirige l'utilisateur vers la page de recherche avec la requête de recherche
      this.search = true;
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

</style>