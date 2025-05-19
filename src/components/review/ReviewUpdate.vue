<template>
  <div class="review-update">
    <h2>리뷰 수정</h2>
    <form @submit.prevent="update">
      <input v-model="title" type="text" />
      <textarea v-model="content"></textarea>
      <button type="submit">수정하기</button>
    </form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getReviewById, updateReview } from '@/api/review'

const route = useRoute()
const router = useRouter()
const reviewId = route.params.reviewId

const title = ref('')
const content = ref('')

onMounted(async () => {
  const res = await getReviewById(reviewId)
  title.value = res.data.title
  content.value = res.data.content
})

const update = async () => {
  try {
    await updateReview(reviewId, title.value, content.value)
    router.push({ name: 'reviewDetail', params: { reviewId } })
  } catch (e) {
    console.error("수정 실패", e)
  }
}
</script>
