<template>
  <div v-if="review">
    <h2>{{ review.title }}</h2>
    <p>{{ review.content }}</p>
    <p>조회수: {{ review.clickCount }}</p>
    <button @click="edit">수정</button>
    <button @click="remove">삭제</button>
  </div>
  <div v-else>
    <p>리뷰를 불러오는 중...</p>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getReviewDetail, deleteReview, updateClickCount } from '@/api/review'

const route = useRoute()
const router = useRouter()
const reviewId = route.params.reviewId

const review = ref(null)

onMounted(async () => {
  try {
    await updateClickCount(reviewId)
    review.value = await getReviewDetail(reviewId)
  } catch (e) {
    console.error("리뷰 조회 실패", e)
  }
})

const edit = () => {
  router.push({ name: 'reviewUpdate', params: { reviewId } })
}

const remove = async () => {
  try {
    await deleteReview(reviewId)
    router.push({ name: 'reviewList', query: { videoId: review.value.videoId } })
  } catch (e) {
    console.error("삭제 실패", e)
  }
}

</script>
