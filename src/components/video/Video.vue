<template>
    <div class="container my-3" id="searchbar">
        <form @submit.prevent="onSearch">
          <div class="d-flex align-items-center gap-2">
            <img src="../../assets/images/search.png" alt="Search" />
            <input
              v-model="searchQuery"
              class="form-control"
              type="text"
              placeholder="운동 제목 검색"
              name="content"
            />
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
          <div
            class="box col-4"
            v-for="(exer, index) in filteredExers"
            :key="index"
          >
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

<script>
import '@/assets/main.css'

export default {
  data() {
    return {
      isLoggedIn: false,
      searchQuery: "",
      selectedPart: "all",
      exers: [
        {
          videoId: 1,
          url: "https://www.youtube.com/embed/example1",
          title: "전신 운동 1",
          part: "whole",
        },
        {
          videoId: 2,
          url: "https://www.youtube.com/embed/example2",
          title: "상체 운동 2",
          part: "upper",
        },
        {
          videoId: 3,
          url: "https://www.youtube.com/embed/example3",
          title: "하체 운동 3",
          part: "lower",
        },
        {
          videoId: 4,
          url: "https://www.youtube.com/embed/example4",
          title: "복부 운동 4",
          part: "abdomen",
        },
      ],
    };
  },
  computed: {
    filteredExers() {
      if (this.selectedPart === "all") return this.exers;
      return this.exers.filter((e) => e.part === this.selectedPart);
    },
  },
  methods: {
    onSearch() {
      alert(`검색 기능 구현 예정: ${this.searchQuery}`);
    },
  },
};

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