<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getReviewDetail, deleteReview, updateClickCount } from '@/api/review'

const route = useRoute()
const router = useRouter()
const reviewId = route.params.reviewId

const review = ref(null)

onMounted(async () => {
  await updateClickCount(reviewId)
  review.value = await getReviewDetail(reviewId)
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
