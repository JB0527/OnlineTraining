<template>
  <div class="review-detail" v-if="review">
    <h2>{{ review.title }}</h2>
    <div class="meta">
      <span>작성자: {{ review.writer }}</span>
      <span>조회수: {{ review.clickCount }}</span>
      <span>작성일: {{ review.writedTime }}</span>
    </div>
    <p class="content">{{ review.content }}</p>

    <div class="buttons">
      <RouterLink :to="`/review/edit/${review.reviewId}`">수정</RouterLink>
      <button @click="deleteReview">삭제</button>
      <RouterLink :to="`/review?videoId=${review.videoId}`">목록으로</RouterLink>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()
const reviewId = route.params.reviewId
const review = ref(null)

const fetchReview = async () => {
  try {
    await axios.put(`/api/review/count/${reviewId}`) // 조회수 증가
    const res = await axios.get(`/api/review/${reviewId}`)
    review.value = res.data
  } catch (err) {
    console.error("리뷰 조회 실패", err)
  }
}

const deleteReview = async () => {
  if (!confirm("정말 삭제하시겠습니까?")) return
  try {
    await axios.delete(`/api/review/${reviewId}`)
    router.push(`/review?videoId=${review.value.videoId}`)
  } catch (err) {
    console.error("삭제 실패", err)
  }
}

onMounted(() => {
  fetchReview()
})
</script>

<style scoped>
.review-detail {
  padding: 20px;
}
.meta {
  font-size: 0.9em;
  color: #666;
  margin-bottom: 10px;
}
.content {
  margin-top: 15px;
  line-height: 1.5;
}
.buttons {
  margin-top: 20px;
}
.buttons a,
.buttons button {
  margin-right: 10px;
  padding: 6px 12px;
  border: none;
  background: #3c526b;
  color: white;
  border-radius: 5px;
  text-decoration: none;
  cursor: pointer;
}
.buttons button:hover,
.buttons a:hover {
  background: #2e3d52;
}
</style>
