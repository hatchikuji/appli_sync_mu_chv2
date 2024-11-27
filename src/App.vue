<template>
  <div id="app">
    <header>
      <!-- Affiche le nom d'utilisateur s'il est connecté -->
      <p v-if="isLoggedIn">Connecté en tant que: {{ user_name }}</p>
      <!-- Boutton pour ouvrir le chat -->
      <button v-if="isLoggedIn" @click="toggleDrawer" class="drawer-toggle">
        {{ isDrawerOpen ? "Fermer le chat" : "Ouvrir le chat" }}
      </button>
    </header>
    <main>
      <div v-if="isLoggedIn">
        <!-- Tiroir pour le chat -->
        <div class="drawer" :class="{ open: isDrawerOpen}">
          <h2>Chat</h2>
          <div class="messages">
            <div v-for="(data, index) in messages" :key="index" class="message">
              {{ data.user_name }}: {{ data.text }}
            </div>
          </div>
          <input v-model="newMessage" @keyup.enter="sendMessage" placeholder="Entrez votre message..."/>
          <button @click="sendMessage">Envoyer</button>
        </div>
      </div>
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
    };
  },
  methods: {
    toggleDrawer() {
      this.isDrawerOpen = !this.isDrawerOpen; // Ouvre/ferme le chat
    },
    handleLogin({username}) {
      this.isLoggedIn = true; // Connecte l'utilisateur
      this.user_name = username; // Récupère le nom d'utilisateur
      this.socket = io("http://localhost:3000"); // Connexion au serveur socket.io
      this.socket.on("new_message", (data) => {
        this.messages.push(data);
      });
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
    },
    async handleLogout() {
      try {
        await fetch("/api/user/logout", {
          method: "POST",
          credentials: "include"
        });
        this.isLoggedIn = false; // Déconnecte l'utilisateur
      } catch (error) {
        console.error("Erreur lors de la déconnexion:", error);
      }
    },
    toggleForm() {
      // Inverse la valeur de showLoginForm pour afficher le formulaire d'inscription
      this.showLoginForm = !this.showLoginForm;
    },
  },
  mounted() {
    eventBus.on("login", ({userId, username}) => {
      this.handleLogin({userId, username});
    });
  }
};
</script>
<style scoped>
/* Styles pour le bouton du tiroir */
.drawer-toggle {
  position: absolute;
  top: 10px;
  right: 10px;
  padding: 10px;
  cursor: pointer;
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
  margin-top: 5px;
  padding: 5px;
  border: 1px solid #ddd;
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
</style>