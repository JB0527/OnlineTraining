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
