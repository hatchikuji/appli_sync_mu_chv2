<template>
  <div id="app">
    <header>
      <h1>App_sync_mu_chv0.2.0</h1>
    </header>
    <main>
      <div v-if="isLoggedIn">
        <button @click="toggleDrawer">Chat</button>
        <div v-show="isDrawerOpen" class="chat-drawer">
          <h2>Chat</h2>
          <div class="message">
            <div v-for="(msg, index) in messages" :key="index" class="message">
              {{ userName }}: {{ msg.text }}
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
      isDrawerOpen: false, // Affiche le chat
      newMessage: "", // Nouveau message
      messages: [], // Liste des messages
      userName: null, // Initialiser avec `null` pour indiquer qu'il est en cours de chargement
    };
  },
  methods: {
    handleLogin({userId, username}) {
      this.isLoggedIn = true; // Connecte l'utilisateur
      this.userName = username; // Récupère le nom d'utilisateur
    },
    async sendMessage() {
      if (this.userName && this.newMessage) {
        eventBus.emit("message", {
          userName: this.userName,
          text: this.newMessage,
        });
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
    toggleDrawer() {
      this.isDrawerOpen = !this.isDrawerOpen;
    }
  },
  mounted() {
    eventBus.on("login", ({userId, username}) => {
      this.handleLogin({userId, username});
    });
    eventBus.on("message", (msg) => {
      console.log("Message reçu:", msg);
      this.messages.push(msg);
    });
  }
};
</script>


<style scoped>
.logreg-form {
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 5px;
}
.chat-drawer {
  border: 1px solid #ddd;
  border-radius: 5px;
  padding: 10px;
  margin-top: 10px;
}
.message {
  margin-top: 10px;
}
</style>
