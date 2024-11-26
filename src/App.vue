<template>
  <div id="app">
    <header>
      <h1>App_sync_mu_chv0.2.0</h1>
    </header>
    <main>
      <div v-if="isLoggedIn">
        <h2>Chat</h2>
        <div class="message">
          <div v-for="(data, index) in messages" :key="index" class="message">
            {{ data.user_name }}: {{ data.text }}
          </div>
        </div>
        <input v-model="newMessage" @keyup.enter="sendMessage" placeholder="Entrez votre message..."/>
        <button @click="sendMessage">Envoyer</button>
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
import { io } from "socket.io-client";

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
      socket: null,
    };
  },
  methods: {
    handleLogin({username}) {
      this.isLoggedIn = true; // Connecte l'utilisateur
      this.user_name = username; // Récupère le nom d'utilisateur

      this.socket = io("http://localhost:3000");

      this.socket.on("new_message", (data) => {
        console.log("Données reçues: ", data);
        this.messages.push(data);
      });
      
    },
    sendMessage() {
      if (this.user_name && this.newMessage) {
        const data = {
          user_name: this.user_name,
          text: this.newMessage,
        };
        this.socket.emit("send_message",  data);
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
