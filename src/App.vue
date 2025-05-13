<template>
  <div>
    <!-- 헤더 -->
    <header>
      <div class="header d-flex justify-content-between align-items-center p-3">
        <div class="logo-box">
          <a href="/"><img class="logo" src="./assets/images/logo.png" alt="Logo" /></a>
        </div>
        <div class="header-right d-flex align-items-center gap-3">
          <div>
            <a v-if="!isLoggedIn" href="/login">로그인</a>
            <a v-else href="/logout">로그아웃</a>
          </div>
          <div>헬스장 찾기</div>
          <div class="user">
            <img src="./assets/images/user.png" alt="User" />
          </div>
        </div>
      </div>
    </header>

    <!-- 검색창 -->
    <main>
      <div class="container my-3" id="searchbar">
        <form @submit.prevent="onSearch">
          <div class="d-flex align-items-center gap-2">
            <img src="./assets/images/search.png" alt="Search" />
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
    </main>

    <!-- 푸터 -->
    <footer class="mt-5 p-4 bg-light">
      <div class="footer-text mb-2">
        <p>고객센터</p>
        <p>서비스 이용약관</p>
        <p>개인정보 처리방침</p>
        <p>도움말</p>
      </div>
      <div class="footer-extra text-secondary small">
        <p><b>SSAFIT 대표 : 옥준</b></p>
        <p>서울특별시 강남구 테헤란로 212 멀티캠퍼스 역삼 504</p>
        <p>사업자등록번호 : 000-00-00000 유료직업소개사업등록번호: 제0000-0000000-00-0-00000호</p>
      </div>
    </footer>
  </div>
</template>

<script>
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
