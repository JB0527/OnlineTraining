<template>
  <div class="review-list">
    <h2>리뷰 목록</h2>
    <div v-if="reviews.length === 0">리뷰가 없습니다.</div>
    <ul v-else>
      <li v-for="review in reviews" :key="review.reviewId" class="review-item">
        <RouterLink :to="`/review/${review.reviewId}`">
          <h3>{{ review.title }}</h3>
        </RouterLink>
        <p>작성자: {{ review.writer }}</p>
        <p>조회수: {{ review.clickCount }}</p>
      </li>
    </ul>
    <RouterLink :to="`/review/write/${videoId}`" class="write-link">리뷰 작성하기</RouterLink>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const videoId = parseInt(route.query.videoId || '0')  // ?videoId=1 식으로 전달
const reviews = ref([])

const fetchReviews = async () => {
  try {
    const res = await axios.get(`/api/review/list?videoId=${videoId}`)
    reviews.value = res.data
  } catch (error) {
    console.error("리뷰 목록 가져오기 실패", error)
  }
}

onMounted(() => {
  fetchReviews()
})
</script>

<style scoped>
.review-list {
  padding: 20px;
}
.review-item {
  border-bottom: 1px solid #ddd;
  padding: 10px 0;
}
.write-link {
  display: inline-block;
  margin-top: 20px;
  background: #3c526b;
  color: white;
  padding: 10px;
  border-radius: 5px;
  text-decoration: none;
}
.write-link:hover {
  background: #2e3d52;
}
</style>
