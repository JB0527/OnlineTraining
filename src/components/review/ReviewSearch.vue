<template>
  <div class="review-search">
    <h2>리뷰 검색</h2>
    <input v-model="searchContent" @keyup.enter="search" type="text" placeholder="내용으로 검색" />
    <button @click="search">검색</button>

    <div v-if="reviews.length">
      <ReviewItem v-for="review in reviews" :key="review.reviewId" :review="review" />
    </div>
    <div v-else>
      <p>검색 결과가 없습니다.</p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'
import ReviewItem from './ReviewItem.vue'
import { useRoute } from 'vue-router'

const searchContent = ref('')
const reviews = ref([])

const route = useRoute()
const videoId = route.query.videoId

const search = async () => {
  try {
    const res = await axios.get('/api/review/search', {
      params: {
        videoId,
        searchContent: searchContent.value
      }
    })
    reviews.value = res.data
  } catch (error) {
    console.error("검색 실패", error)
  }
}
</script>

<style scoped>
.review-search {
  padding: 20px;
}
input {
  width: 300px;
  padding: 8px;
  margin-right: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}
button {
  padding: 8px 15px;
  background-color: #3c526b;
  color: white;
  border: none;
  border-radius: 5px;
}
button:hover {
  background-color: #2e3d52;
}
</style>
