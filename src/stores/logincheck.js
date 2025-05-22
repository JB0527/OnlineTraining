import { ref } from 'vue'
import { defineStore } from 'pinia'

export const useLoginCheck = defineStore('loginCheck', () => {
    const isLoggedIn = ref(false);

    const login = (userId, userName, token) => {
        sessionStorage.setItem('id', userId);
        sessionStorage.setItem('name', userName);
        sessionStorage.setItem("access-token", token);
        isLoggedIn.value = true
    }

    const logout = () => {
        sessionStorage.clear()
        isLoggedIn.value = false
    }

    const checkLogin = () => {
        isLoggedIn.value = !!sessionStorage.getItem('id')
    }

    return { isLoggedIn, login, logout, checkLogin }
})