<template>
  <div class="header d-flex justify-content-between align-items-center p-3">
    <div class="logo-box">
      <a href="/"><img class="logo" src="../../assets/images/logo.png" alt="Logo" /></a>
    </div>
    <div class="header-right d-flex align-items-center gap-3">
      <div>
        <a href="#" style="color: black; text-decoration: none;" v-if="!subscribeCheck.isSubscribed & loginCheck.isLoggedIn" @click="subscribePay">구독</a>
      </div>
      <div>
        <a href="#" style="color: black; text-decoration: none;" v-if="!loginCheck.isLoggedIn" @click="login">로그인</a>
        <a href="#" style="color: black; text-decoration: none;" v-else @click="logout">로그아웃</a>
      </div>
      <div class="user">
        <img src="../../assets/images/user.png" alt="User" />
      </div>
    </div>
  </div>
</template>

<script setup>
import '@/assets/main.css';
import '@/assets/base.css';

import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useLoginCheck } from '@/stores/logincheck'
import { useSubscribeCheck } from '@/stores/subscribe'

const loginCheck = useLoginCheck();
loginCheck.checkLogin();

const subscribeCheck = useSubscribeCheck();
subscribeCheck.checkSubscribe();

const router = useRouter();

const login = () => {
  router.push('/user/login')
}

const logout = () => {
  loginCheck.logout();
  subscribeCheck.logout();
  router.push('/');
}
</script>
