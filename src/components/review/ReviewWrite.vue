<template>
  <div class="review-write">
    <h2>리뷰 작성</h2>
    <form @submit.prevent="submitReview">
      <input v-model="review.title" type="text" placeholder="제목" required />
      <textarea v-model="review.content" placeholder="내용을 입력하세요" required></textarea>
      <button type="submit">작성 완료</button>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const route = useRoute()
const videoId = route.query.videoId || 1  // 기본값 1

const review = ref({
  videoId: parseInt(videoId),
  title: '',
  content: '',
  writer: '익명',
  writerId: 0,
  writedTime: new Date().toISOString().split('T')[0],
  clickCount: 0
})

const submitReview = async () => {
  try {
    await axios.post('/api/review', review.value)
    router.push(`/review?videoId=${review.value.videoId}`)
  } catch (error) {
    console.error("리뷰 작성 실패", error)
  }
}
</script>

<style scoped>
.review-write {
  padding: 20px;
}
input,
textarea {
  display: block;
  width: 100%;
  margin-bottom: 10px;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 5px;
}
textarea {
  height: 120px;
}
button {
  padding: 10px 20px;
  background-color: #3c526b;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}
button:hover {
  background-color: #2e3d52;
}
</style>
