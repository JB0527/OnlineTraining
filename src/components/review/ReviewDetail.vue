<template>
  <div class="review-tight-container">
    <iframe
      class="review-iframe"
      :src="video.url"
      title="YouTube video player"
      frameborder="0"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
      referrerpolicy="strict-origin-when-cross-origin"
      allowfullscreen>
    </iframe>

    <div v-if="review" class="review-tight-card">
      <h2 class="tight-title">{{ review.title }}</h2>
      <p class="tight-count">조회수: {{ review.clickCount }}</p>
      <p class="tight-content">{{ review.content }}</p>

      <div class="tight-button-group">
        <button @click="edit">수정</button>
        <button @click="remove">삭제</button>
        <button @click="list">목록</button>
      </div>
    </div>
    <div v-else>
      <p>리뷰를 불러오는 중...</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getReviewDetail, deleteReview, updateClickCount } from '@/api/review'
import { getVideoDetail } from '@/api/video'

const route = useRoute()
const router = useRouter()
const reviewId = route.params.reviewId
const video = ref({});

const videoId = route.query.videoId;
const videoUrl = ref('')


const review = ref(null)

onMounted(async () => {
  video.value = await getVideoDetail(videoId);
  try {
    await updateClickCount(reviewId)
    review.value = await getReviewDetail(reviewId)
  } catch (e) {
    console.error("리뷰 조회 실패", e)
  }
})

const edit = () => {
  const writerId = sessionStorage.getItem('id');
  if (writerId !== review.value.writerId) {
    alert('작성자만 수정할 수 있습니다.')
    return
  }
  router.push({ name: 'reviewUpdate', params: { reviewId }, query: { videoId } })
}

const remove = async () => {
  const writerId = sessionStorage.getItem('id');
  if (writerId !== review.value.writerId) {
    alert('작성자만 삭제할 수 있습니다.')
    return
  }
  try {
    await deleteReview(reviewId)
    await router.push({name: 'reviewList', query: {videoId}})
  } catch (e) {
    console.error("삭제 실패", e)
  }
}

const list = () => {
  router.push({ name: 'reviewList', query: { videoId } })
}
</script>
<style scoped>
.review-tight-container {
  background-color: #0a0f1a;
  color: #e6ecff;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.review-iframe {
  width: 560px;
  height: 315px;
  margin: 0;
  padding: 0;
  border: none;
}

.review-tight-card {
  padding: 0;
  margin: 0;
  width: 560px;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.tight-title {
  font-size: 1.6rem;
  font-weight: bold;
  color: #66b3ff;
  margin: 4px 0;
}

.tight-count {
  font-size: 1.1rem;
  margin: 2px 0;
  color: #99bbff;
}

.tight-content {
  font-size: 1.15rem;
  margin: 4px 0;
  color: #cfd8ff;
  white-space: pre-wrap;
}

.tight-button-group {
  display: flex;
  gap: 8px;
  margin-top: 6px;
}

.tight-button-group button {
  font-size: 1rem;
  padding: 6px 12px;
  border: none;
  border-radius: 6px;
  background-color: #007bff;
  color: white;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.tight-button-group button:hover {
  background-color: #0056cc;
}
</style>
