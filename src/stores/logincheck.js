import { ref } from 'vue'
import { defineStore } from 'pinia'

export const useLoginCheck = defineStore('loginCheck', () => {
    const isLoggedIn = ref(false);

    const login = (userId) => {
        sessionStorage.setItem('id', userId)
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