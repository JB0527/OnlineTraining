<template>
  <div class="container">
    <div class="card">
      <h1 class="title">Subscribe</h1>
      <p class="description">
  좋아하는 영상의 리뷰를 감상하고, 더 깊이 느껴보세요.<br>
  단돈 1,000원으로 모든 서비스를 누릴 수 있어요!<br>
  결제는 네이버페이로만 가능합니다 😊
</p>

      <button 
        @click="requestSubscribe" 
        class="subscribe-btn"
      >
        구독하기
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useSubscribeCheck } from '@/stores/subscribe'
import { subscribe } from '@/api/user'
import { useRouter } from 'vue-router';

const subscribeCheck = useSubscribeCheck();
subscribeCheck.checkSubscribe();
const router = useRouter();

onMounted(() => {
  const stored = sessionStorage.getItem('subscribe')
  if (stored === 'true') {
    isSubscribed.value = true
  }
})

const requestSubscribe = async () => {
    const userId = sessionStorage.getItem("id");
    await subscribe(userId);
    subscribeCheck.isSubscribed = true;
    sessionStorage.setItem("subscribe", true);
    router.replace('/');
}
</script>

<style scoped>
.container {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background: linear-gradient(to bottom right, #dbeafe, #ddd6fe);
  padding: 20px;
}

.card {
  background-color: white;
  padding: 30px 40px;
  border-radius: 16px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  text-align: center;
  max-width: 400px;
  width: 100%;
}

.title {
  font-size: 24px;
  font-weight: bold;
  color: #1f2937;
  margin-bottom: 16px;
}

.description {
  color: #4b5563;
  font-size: 16px;
  line-height: 1.6;
  margin-bottom: 24px;
  background-color: #f9fafb;
  padding: 16px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}


.subscribe-btn {
  background-color: #3b82f6;
  color: white;
  border: none;
  padding: 12px 24px;
  font-size: 16px;
  border-radius: 12px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  width: 100%;
}

.subscribe-btn:hover {
  background-color: #2563eb;
}

.subscribe-btn.disabled {
  background-color: #9ca3af;
  cursor: not-allowed;
}
</style>
