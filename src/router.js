import {createRouter, createWebHistory} from "vue-router";
import loginForm from "./components/LoginForm.vue";
const routes = [
    {path: '/', redirect: '/login'}, // Redirige vers la page de connexion
    {path: '/login', component: loginForm},
    ];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;