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
import eventBus from "../eventBus.js";  

export default defineComponent({
  data() {
    return {
      username: '',
      password: '',
      isLoggedIn: false, // État de connexion
      errorMessage: '',
    };
  },
  methods: {
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
          eventBus.emit('login', { userId: data.userId, username: this.username }); // Émet un événement de connexion
        } else {
          this.errorMessage = data.message;
        }
      } catch (error) {
        this.errorMessage = "Erreur de connexion, veuillez réessayer.";
        console.log('Erreur:', error);
      }
    },
  },
});
</script>
<style scoped>

</style>
