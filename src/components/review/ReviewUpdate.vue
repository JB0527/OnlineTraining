<template>
  <div class="review-update">
    <h2>리뷰 수정</h2>
    <form @submit.prevent="updateReview">
      <input v-model="review.title" type="text" placeholder="제목" required />
      <textarea v-model="review.content" placeholder="내용을 입력하세요" required></textarea>
      <button type="submit">수정 완료</button>
    </form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()
const reviewId = route.query.reviewId

const review = ref({
  title: '',
  content: ''
})

const fetchReview = async () => {
  try {
    const res = await axios.get(`/api/review/${reviewId}`)
    review.value = {
      title: res.data.title,
      content: res.data.content
    }
  } catch (error) {
    console.error("리뷰 가져오기 실패", error)
  }
}

const updateReview = async () => {
  try {
    await axios.put(`/api/review/${reviewId}`, {
      reviewId: parseInt(reviewId),
      title: review.value.title,
      content: review.value.content
    })
    router.push(`/review/detail?reviewId=${reviewId}`)
  } catch (error) {
    console.error("리뷰 수정 실패", error)
  }
}

onMounted(fetchReview)
</script>

<style scoped>
.review-edit {
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
