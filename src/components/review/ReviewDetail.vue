<template>
  <div class="review-tight-container">
    <div class="video-wrapper">
      <iframe class="review-iframe" :src="video.url" title="YouTube video player" frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
        referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
      </iframe>
    </div>

    <div v-if="review" class="review-tight-card bg-black text-white p-4 rounded-4 shadow-sm">
      <div class="review-header mb-4">
        <h2 class="tight-title fw-bold text-primary mb-2">{{ review.title }}</h2>
        <p class="tight-count text-secondary d-flex align-items-center">
          <i class="bi bi-eye me-1"></i><span>{{ review.clickCount }}회</span>
        </p>
      </div>

      <div class="review-body mb-4">
        <p class="tight-content">{{ review.content }}</p>
      </div>

      <div class="tight-button-group d-flex flex-wrap gap-2 justify-content-end">
        <button @click="edit" class="btn btn-outline-warning btn-sm">수정</button>
        <button @click="remove" class="btn btn-outline-danger btn-sm">삭제</button>
        <button @click="list" class="btn btn-outline-light btn-sm">목록</button>
      </div>
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
    await router.push({ name: 'reviewList', query: { videoId } })
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
  padding: 2rem 1rem;
  margin: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.video-wrapper {
  width: 100%;
  display: flex;
  justify-content: center;
  margin-bottom: 2rem;
}

.review-iframe {
  width: 100%;
  max-width: 560px;
  height: 315px;
  border: none;
  border-radius: 0.5rem;
}

.review-tight-card {
  width: 100%;
  max-width: 800px;
  word-break: break-word;
  background-color: #121926;
  border-radius: 1rem;
  padding: 2rem;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.review-header {
  border-bottom: 1px solid #333;
  padding-bottom: 1rem;
  margin-bottom: 1rem;
}

.review-body {
  padding-top: 1rem;
  border-top: 1px solid #333;
  font-size: 1.05rem;
  line-height: 1.6;
}

.tight-button-group button {
  min-width: 80px;
}

@media (max-width: 576px) {
  .tight-title {
    font-size: 1.25rem;
  }
  .tight-content {
    font-size: 0.95rem;
  }
  .tight-button-group {
    flex-direction: column;
    gap: 0.5rem;
    align-items: stretch;
  }
}
</style>
