<template>
  <div class="review-write">
    <h2>리뷰 작성</h2>
    <form @submit.prevent="submit">
      <input v-model="title" type="text" placeholder="제목" required />
      <textarea v-model="content" placeholder="내용" required></textarea>
      <button type="submit">작성하기</button>
      
        <!-- 에러 메시지 -->
      <p v-if="errorMsg" style="color: red; margin-top: 10px;">
        {{ errorMsg }}
      </p>
    </form>
  </div>
</template>
<script setup>
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { writeReview } from '@/api/review'

const route = useRoute()
const router = useRouter()
const errorMsg = ref('');

const videoId = route.query.videoId
const title = ref('')
const content = ref('')
const now = new Date();
const writedTime = now.toISOString().slice(0, 19).replace('T', ' '); 

const submit = async () => {
  errorMsg.value = '';  // 초기화

  try {
    const writerId = sessionStorage.getItem('id');
    const writer = sessionStorage.getItem('name');

    if (!writerId) {
      throw new Error("로그인 정보가 없습니다.");
    }

    await writeReview({
      videoId,
      title: title.value,
      content: content.value,
      writer,
      writerId,
      writedTime
    });

    router.push({ name: 'reviewList', query: { videoId } });
  } catch (e) {
    // e.response?.data가 있으면 그걸로, 없으면 e.message로
    errorMsg.value = e.response?.data || e.message || "작성 실패했습니다.";
    console.error("작성 실패", e.response?.data || e.message);
  }
};
</script>

<style scoped>
.review-write {
  background-color: #0a0f1a;
  color: #e6ecff;
  min-height: 100vh;
  padding: 2rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  display: flex;
  flex-direction: column;
  align-items: center;
}

h2 {
  font-size: 1.8rem;
  color: #3399ff;
  margin-bottom: 1.5rem;
  text-align: center;
}

form {
  display: flex;
  flex-direction: column;
  width: 100%;
  max-width: 600px;
  background-color: #121a36;
  padding: 2rem;
  border-radius: 12px;
  box-shadow: 0 0 20px #007bff33;
}

input[type="text"],
textarea {
  background-color: #1a2238;
  color: #e0e7ff;
  border: 1px solid #334066;
  padding: 0.8rem 1rem;
  margin-bottom: 1rem;
  border-radius: 8px;
  font-size: 1rem;
  resize: vertical;
}

input::placeholder,
textarea::placeholder {
  color: #7789a8;
}

button[type="submit"] {
  background-color: #007bff;
  color: white;
  border: none;
  font-weight: 600;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  cursor: pointer;
  font-size: 0.7rem;
  box-shadow: 0 0 8px #007bff88;
  transition: background-color 0.3s ease, transform 0.2s ease;
}

button[type="submit"]:hover {
  background-color: #0056cc;
  transform: translateY(-1px);
}

/* 에러 메시지 스타일 */
form p {
  color: #ff6b6b;
  font-weight: 500;
  font-size: 0.95rem;
  margin-top: 0.8rem;
  text-align: center;
}
</style>