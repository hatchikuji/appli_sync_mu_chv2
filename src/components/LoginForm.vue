<template>
  <div v-if="!isLoggedIn">
    <div class="login-form">
      <h2>Connexion</h2>
      <form @submit.prevent="handleLogin">
        <div class="form-group">
          <label for="username">Nom d'utilisateur</label>
          <input
              type="text"
              v-model="username"
              id="username"
              class="form-control"
              required/>
        </div>
        <div class="form-group">
          <label for="password">Mot de passe</label>
          <input
              type="password"
              v-model="password"
              id="password"
              class="form-control"
              required
          />
        </div>
        <button type="submit" class="btn btn-primary">Se connecter</button>
      </form>
      <p v-if="errorMessage" class="text-danger">{{ errorMessage }}</p>
    </div>
  </div>
</template>

<script>
import {defineComponent} from 'vue';
import { io } from 'socket.io-client';
import eventBus from "../eventBus.js";  

export default defineComponent({
  data() {
    return {
      username: '',
      password: '',
      isLoggedIn: false, // État de connexion
      errorMessage: '',
      socket: null // Instance de socket.io
    };
  },
  mounted() {
    this.checkSession(); // Vérifie si l'utilisateur est déjà connecté
  },
  methods: {
    async checkSession() {
      try {
        const response = await fetch(`/api/user/session`, {
          credentials: 'include',
        });
        if (!response.ok) {
          throw new Error(`Erreur HTTP! statut: ${response.status}`);
        }
        const data = await response.json();
        if (data.isLoggedIn) {
          this.isLoggedIn = true; // État de connexion
          this.connectSocket(); // Connecte le socket
        }
      } catch (error) {
        console.log('Erreur lors de l\'initialisation de la session ou session non initialisée', error);
      }
    },
    async handleLogin() {
      try {
        const response = await fetch('/api/user/login', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            username: this.username,
            password: this.password,
          }),
        });

        const data = await response.json();

        if (response.ok) {
          this.isLoggedIn = true; // Met à jour l'état de connexion
          this.connectSocket(); // Connecte le socket
          eventBus.emit('login', { userId: data.userId, username: this.username }); // Émet un événement de connexion
        } else {
          this.errorMessage = data.message;
        }
      } catch (error) {
        this.errorMessage = "Erreur de connexion, veuillez réessayer.";
        console.log('Erreur:', error);
      }
    },
    async handleLogout() {
      try {
        const response = await fetch('/api/logout', {
          method: 'POST',
          credentials: 'include',
        });

        if (response.ok) {
          this.isLoggedIn = false; // Met à jour l'état de connexion
          if (this.socket){
            this.socket.disconnect(); // Déconnecte le socket
          }
        } else {
          console.error('Erreur de déconnexion:', response.statusText);
        }
      } catch (error) {
        console.error('Erreur:', error);
      }
    },
    connectSocket() {
      this.socket = io();
      this.socket.on('connect', () => {
        console.log('Socket connecté au serveur, ID:', this.socket.id);
      });
      this.socket.on('disconnect', () => {
        console.log('Socket déconnecté du serveur');
      });
    },
  },
});
</script>

<style scoped>

</style>
