import { defineStore } from "pinia";
import {ref} from 'vue';

export const useSubscribeCheck = defineStore("", () => {
    const isSubscribed = ref(false);

    const subscribe = (data) => {
        
        console.log(typeof(data))
        console.log(data)
        if(data) {
            sessionStorage.setItem('subscribe', data);
            isSubscribed.value = true
        }
    }

    const logout = () => {
        sessionStorage.clear()
        isSubscribed.value = false
    }


    const checkSubscribe = () => {
        isSubscribed.value = !!sessionStorage.getItem('subscribe')
    }

    return { isSubscribed, logout, subscribe, checkSubscribe }
})