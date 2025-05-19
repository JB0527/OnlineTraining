<template>
  <div class="container my-3" id="searchbar">
    <form @submit.prevent="onSearch">
      <div class="d-flex align-items-center gap-2">
        <img src="../../assets/images/search.png" alt="Search" />
        <input v-model="searchQuery" class="form-control" type="text" placeholder="운동 제목 검색" name="content" />
      </div>
    </form>
  </div>

  <!-- 최근 영상 -->
  <div class="container" id="최근영상">
    <h5 class="fw-semibold text-primary">최근 가장 많이 본 영상</h5>
    <div class="row">
      <div class="box col-4" v-for="(exer, index) in exers.slice(0, 3)" :key="index">
        <div class="ratio ratio-16x9">
          <iframe :src="exer.url" allowfullscreen></iframe>
        </div>
        <div class="row" id="제목">
          <a :href="`/review?videoId=${exer.videoId}`">{{ exer.title }}</a>
        </div>
      </div>
    </div>
  </div>

  <!-- 운동 부위 선택 -->
  <div class="container mt-5" id="운동부위">
    <h5 class="fw-semibold text-primary">운동 부위 선택</h5>
    <div class="mb-3">
      <a href="#" @click.prevent="selectedPart = 'all'">전체</a>
      <a href="#" @click.prevent="selectedPart = 'whole'">전신</a>
      <a href="#" @click.prevent="selectedPart = 'upper'">상체</a>
      <a href="#" @click.prevent="selectedPart = 'lower'">하체</a>
      <a href="#" @click.prevent="selectedPart = 'abdomen'">복부</a>
    </div>
    <div class="row">
      <div class="box col-4" v-for="(exer, index) in filteredExers" :key="index">
        <div class="ratio ratio-16x9">
          <iframe :src="exer.url" allowfullscreen></iframe>
        </div>
        <div class="row" id="제목">
          <a :href="`/review?videoId=${exer.videoId}`">{{ exer.title }}</a>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, computed, onMounted } from 'vue'
import '@/assets/main.css'
import { getVideoList } from "@/api/video"

// 상태 변수들
const isLoggedIn = ref(false)
const searchQuery = ref("")
const selectedPart = ref("all")
const exers = ref([])

// 비디오 리스트 요청
const requestBoardList = async () => {
  exers.value = await getVideoList()
}

onMounted(() => {
  requestBoardList()
})

// 검색 필터링
const filteredExers = computed(() => {
  if (selectedPart.value === "all") return exers.value
  return exers.value.filter(e => e.part === selectedPart.value)
})

// 검색 버튼 클릭
const onSearch = () => {
  alert(`검색 기능 구현 예정: ${searchQuery.value}`)
}
</script>


<style scoped>
.logo {
  height: 40px;
}

.user img {
  width: 32px;
  height: 32px;
}

a {
  text-decoration: none;
  margin-right: 10px;
  color: #3c526b;
}

a:hover {
  text-decoration: underline;
}

.box {
  padding: 10px;
}

#제목 {
  margin-top: 5px;
  font-weight: 500;
  color: #3c526b;
}
</style>