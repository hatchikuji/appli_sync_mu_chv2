<template>
  <div class="register-form">
    <h2>Inscription</h2>
    <form @submit.prevent="handleRegister">
      <div class="form-group">
        <label for="email">Adresse email</label>
        <input
            type="email"
            v-model="email"
            id="email"
            class="form-control"
            required
        />
      </div>
      <div class="form-group">
        <label for="username">Nom d'utilisateur</label>
        <input
            type="text"
            v-model="username"
            id="username"
            class="form-control"
            required
        />
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
      <div class="form-group">
        <label for="cpassword">Confirmer le mot de passe</label>
        <input
            type="password"
            v-model="cpassword"
            id="cpassword"
            class="form-control"
            required
        />
      </div>
      <button type="submit" class="btn btn-primary">S'inscrire</button>
    </form>
    <p v-if="errorMessage" class="text-danger">{{ errorMessage }}</p>
  </div>
</template>

<script>

export default {
  data() {
    return {
      email: '',
      username: '',
      password: '',
      cpassword: '',
      errorMessage: ''
    };
  },
  methods: {
    async handleRegister() {
      if (this.password !== this.cpassword) {
        this.errorMessage = "Les mots de passe ne correspondent pas.";
        return;
      }

      try {
        const response = await fetch('/api/user/register',{
          method: 'POST',
          headers:{
            'Content-Type':'application/json',
          },
          body: JSON.stringify({
            email: this.email,
            username: this.username,
            password: this.password,
          }),
        });

        const data = await response.json()

        if (response.ok) {
          console.log('Utilisateur enregistré avec succès!', data);
          // Réinitialise le formulaire
          this.email = '';
          this.username = '';
          this.password = '';
          this.cpassword = '';

          // Redirige l'utilisateur vers la page principale
        } else {
          console.error('Erreur d\'inscription:', data.message);
          this.errorMessage = data.message;
        }
      } catch (error) {
        this.errorMessage = "Erreur de connexion, veuillez réessayer.";
        console.error('Erreur:', error);
      }
    },
  },
};
</script>

<style scoped>

</style>
