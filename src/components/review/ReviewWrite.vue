<template>
  <div class="review-write">
    <h2>리뷰 작성</h2>
    <form @submit.prevent="submit">
      <input v-model="title" type="text" placeholder="제목" required />
      <textarea v-model="content" placeholder="내용" required></textarea>
      <button type="submit">작성하기</button>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { addReview } from '@/api/review'

const route = useRoute()
const router = useRouter()

const videoId = route.query.videoId
const title = ref('')
const content = ref('')

const submit = async () => {
  try {
    await addReview({
      videoId,
      title: title.value,
      content: content.value
    })
    router.push({ name: 'reviewList', params: { videoId } })
  } catch (e) {
    console.error("작성 실패", e)
  }
}
</script>
