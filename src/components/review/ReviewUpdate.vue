<template>
  <div class="review-update">
    <h2>리뷰 수정</h2>
    <form @submit.prevent="update">
      <input v-model="title" type="text" placeholder="제목" required />
      <textarea v-model="content" placeholder="내용" required></textarea>
      <button type="submit">수정하기</button>
    </form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getReviewDetail, updateReview } from '@/api/review'

const route = useRoute()
const router = useRouter()
const reviewId = route.params.reviewId
const videoId = route.query.videoId;

const title = ref('')
const content = ref('')

onMounted(async () => {
  console.log('받은 reviewId:', reviewId)
  try {
    const res = await getReviewDetail(reviewId)
    console.log('받은 리뷰 내용:', res)
    title.value = res.title
    content.value = res.content
  } catch (e) {
    console.error('리뷰 가져오기 실패:', e)
  }
})

const update = async () => {
  try {
    await updateReview(reviewId, {
      title: title.value,
      content: content.value
    })
    router.push({ name: 'reviewDetail', params: { reviewId }, query: {videoId} })
  } catch (e) {
    console.error("수정 실패", e)
  }
}
</script>

<style scoped>
.review-update {
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

input[type="text"]::placeholder,
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
  font-size: 1rem;
  box-shadow: 0 0 8px #007bff88;
  transition: background-color 0.3s ease, transform 0.2s ease;
}

button[type="submit"]:hover {
  background-color: #0056cc;
  transform: translateY(-1px);
}

</style>