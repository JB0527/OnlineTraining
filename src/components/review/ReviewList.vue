<template>
  <div class="review-list">
    <h2>리뷰 목록</h2>
    <input v-model="content" @keyup.enter="search" type="text" placeholder="내용으로 검색" />
    <button @click="search">검색</button>

    <div v-if="reviews.length">
      <ul>
        <li v-for="review in reviews" :key="review.reviewId">
          <RouterLink :to="{ name: 'reviewDetail', params: { reviewId: review.reviewId } }">
            {{ review.title }} - {{ review.writer }}
          </RouterLink>
        </li>
      </ul>
    </div>
    <div v-else>
      <p>검색 결과가 없습니다.</p>
    </div>

    <RouterLink :to="{ name: 'reviewWrite', query: { videoId } }">
      <button>리뷰 작성</button>
    </RouterLink>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { getAllReviews, getSearchReviews } from '@/api/review';

const route = useRoute();
const videoId = route.query.videoId;

const content = ref('');
const reviews = ref([]);

const loadAll = async () => {
  reviews.value = await getAllReviews(videoId);
};

const search = async () => {
  if (content.value.trim() === '') {
    await loadAll();
  } else {
    reviews.value = await getSearchReviews(videoId, content.value);
  }
};

onMounted(loadAll);
</script>

<style scoped>
.review-list {
  padding: 20px;
}
</style>
