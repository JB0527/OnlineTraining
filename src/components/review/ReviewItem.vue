<!-- components/review/ReviewItem.vue -->
<template>
  <div class="review-item">
    <RouterLink :to="{ name: 'reviewDetail', params: { reviewId: review.reviewId } }">
      <h3>{{ review.title }}</h3>
      <p>{{ review.content }}</p>
    </RouterLink>
  </div>
</template>

<script setup>
defineProps({
  review: Object
});
</script>

<style scoped>
.review-item {
  padding: 10px;
  border: 1px solid #ccc;
  margin-bottom: 10px;
}
</style>
