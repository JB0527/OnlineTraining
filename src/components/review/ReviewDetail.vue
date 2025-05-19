<template>
  <div v-if="review" class="review-detail">
    <h2>{{ review.title }}</h2>
    <p>{{ review.content }}</p>
    <p><strong>조회수:</strong> {{ review.clickCnt }}</p>
    <button @click="edit">수정</button>
    <button @click="remove">삭제</button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getReviewById, deleteReview, updateClickCount } from '@/api/review'

const route = useRoute()
const router = useRouter()
const reviewId = route.params.reviewId

const review = ref(null)

onMounted(async () => {
  await updateClickCount(reviewId)
  const res = await getReviewById(reviewId)
  review.value = res.data
})

const edit = () => {
  router.push({ name: 'reviewUpdate', params: { reviewId } })
}

const remove = async () => {
  try {
    await deleteReview(reviewId)
    router.push({ name: 'reviewList', params: { videoId: review.value.videoId } })
  } catch (e) {
    console.error("삭제 실패", e)
  }
}
</script>
