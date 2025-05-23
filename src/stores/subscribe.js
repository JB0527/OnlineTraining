import { defineStore } from "pinia";
import {ref} from 'vue';

export const useSubscribeCheck = defineStore("", () => {
    const isSubscribed = ref(false);

    const subscribe = (isSubscribed) => {
        sessionStorage.setItem('subscribe', isSubscribed);
        if(isSubscribed === 'true') {
            isSubscribed.value = true
        }
    }

    const checkSubscribe = () => {
        isSubscribed.value = !!sessionStorage.getItem('subscribe')
    }

    return { isSubscribed, subscribe, checkSubscribe }
})