# Appli Sync Music Chat

## Description

Appli Sync Music Chat est une application web permettant aux utilisateurs de s'inscrire, de se connecter et d'écouter de la musique ensemble tout en discutant en direct. Cette application utilise Node.js, Express, et MySQL pour le backend, ainsi que Vue + Vite pour le frontend.

## Fonctionnalités

- Inscription des utilisateurs avec validation des données
- Connexion des utilisateurs
- Envoi et réception de messages en temps réel via WebSocket
- Hachage sécurisé des mots de passe

## Prérequis

Avant de commencer, assurez-vous d'avoir les éléments suivants installés sur votre machine :

- [Node.js](https://nodejs.org/) (version 14 ou supérieure)
- [MySQL](https://www.mysql.com/) (ou un autre système de gestion de base de données compatible)

## Installation

1. Clonez le dépôt :

   ```bash
   git clone https://github.com/hatchikuji/appli_sync_mu_chv02.git
   cd appli_sync_mu_chv02
   ```

2. Installez les dépendances pour le backend :
    ```bash
    npm install
    ```

## Configuration de la base de données/navigateur.

1. Créez une base de données MySQL pour votre projet :

   ```sql
   CREATE DATABASE projetperso;
   ```

2. Modifiez le fichier config.mjs pour ajouter vos informations de connexion MySQL.

## Utilisation :

1. Démarrez le serveur backend :
    ```bash
    node server.js
    ```

Le serveur démarrera sur le port 3000 par défaut.

Ouvrez votre navigateur et accédez à http://localhost:3000/ pour utiliser l'application.

## Dépendances

1. Backend
- nodemon : outil de surveillance des modifications du code pour Node.js
- express : framework web pour Node.js
- mysql2 : bibliothèque pour interagir avec MySQL
- bcrypt : bibliothèque pour le hachage des mots de passe
- socket.io : bibliothèque pour la communication en temps réel
- dotenv : pour la gestion des variables d'environnement
2. Frontend
- vue : framework JavaScript progressif pour construire des interfaces utilisateur
- vue-router : bibliothèque de routage pour Vue.js
3. Scripts
- Pour lancer le serveur backend : node server.mjs
- Pour lancer le frontend : npm run serve (si vous avez configuré un script de démarrage)
4. Gestion des erreurs et logs
- Les événements et les erreurs sont enregistrés dans le fichier server.mjs.log. Assurez-vous de consulter ce fichier pour le débogage et la surveillance.

## Contribuer
Les contributions sont les bienvenues ! Si vous souhaitez améliorer ce projet, n'hésitez pas à ouvrir une demande de tirage.

Auteurs
- [Hatchikuji](https://github.com/hatchikuji) - Développeur principal