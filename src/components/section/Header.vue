<template>
  <div class="header d-flex justify-content-between align-items-center p-3">
        <div class="logo-box">
          <a href="/"><img class="logo" src="../../assets/images/logo.png" alt="Logo" /></a>
        </div>
        <div class="header-right d-flex align-items-center gap-3">
          <div>
            <a v-if="!isLoggedIn" href="/login">로그인</a>
            <a v-else href="/logout">로그아웃</a>
          </div>
          <div>헬스장 찾기</div>
          <div class="user">
            <img src="../../assets/images/user.png" alt="User" />
          </div>
        </div>
      </div>
</template>
<script setup>
import '@/assets/main.css';
import '@/assets/base.css';
</script>
<script>
export default {
  data() {
    return {
      contextRoot: '', // ex) '/your-app', 이 값은 필요 시 props나 환경변수로 주입 가능
      isLoggedIn: false // 실제 로그인 여부에 따라 설정
    };
  },
  mounted() {
    // 예시: 로그인 상태를 로컬 저장소나 API에서 확인
    const userId = sessionStorage.getItem('id');
    this.isLoggedIn = !!userId;

    // 예시: contextRoot를 자동 설정하거나 props로 받을 수도 있음
    this.contextRoot = import.meta.env.VITE_CONTEXT_ROOT || ''; // Vite 사용 시
  }
};
  
</script>
