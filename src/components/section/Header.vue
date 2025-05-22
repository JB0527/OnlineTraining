<template>
  <div class="header d-flex justify-content-between align-items-center p-3">
    <div class="logo-box">
      <a href="/"><img class="logo" src="../../assets/images/logo.png" alt="Logo" /></a>
    </div>
    <div class="header-right d-flex align-items-center gap-3">
      <div>
        <a v-if="!isLoggedIn" @click="login">로그인</a>
        <a v-else @click="logout">로그아웃</a>
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

import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const isLoggedIn = ref(false)

const login = () => {
  router.push('/user/login')
}

const logout = () => {
  sessionStorage.clear()
  isLoggedIn.value = false
}

onMounted(() => {
  // 마운트될 때 로그인 여부 체크
  const userId = sessionStorage.getItem('id')
  isLoggedIn.value = !!userId
  console.log(userId);
})
</script>
