<template>
  <div>
    <!-- 헤더 -->
    <header>
      <Header />
      
      
    </header>

    <!-- 검색창 -->
    <main>
      <RouterLink to="/"></RouterLink>
      <RouterView />
    </main>

    <footer>
      <Footer />
    </footer>

  </div>
</template>

<script setup>
import Header from '@/components/section/Header.vue';
import Footer from '@/components/section/Footer.vue';
</script>
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
