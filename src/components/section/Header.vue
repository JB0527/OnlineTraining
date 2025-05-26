<template>
  <nav class="navbar navbar-expand-md navbar-dark">
    <div class="container"> 
      <!-- Brand --> 
      <a class="navbar-brand mr-auto" href="/"><img src="/src/assets/images/logo.png" alt="FoxPro" /></a> 
      
      <!-- Toggler/collapsibe Button -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar"> <span class="navbar-toggler-icon"></span> </button>
      
      <!-- Navbar links -->
      <div class="collapse navbar-collapse" id="collapsibleNavbar">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item"> <a class="nav-link" href="/video">영상</a> </li>
          <li class="nav-item"> <a class="nav-link" href="#about-us">AI추천</a> </li>
          <li class="nav-item"> <a class="nav-link" href="/user/subscribe" v-if="!subscribeCheck.isSubscribed & loginCheck.isLoggedIn" @click="subscribePay">구독</a> </li>
          <li class="nav-item"> <a class="nav-link" href="#" v-if="!loginCheck.isLoggedIn" @click="login">로그인</a>
          <a class="nav-link" href="#" v-else @click="logout">로그아웃</a> </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useLoginCheck } from '@/stores/logincheck';
import { useSubscribeCheck } from '@/stores/subscribe';

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

const subscribePay = () => {
  router.push('/user/subscribe')
}

</script>
