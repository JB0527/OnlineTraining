<template>
  <div class="container my-3" id="searchbar" v-if="loginCheck.isLoggedIn">
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal-default">
      영상을 등록해보세요!
    </button>
  </div>
  <div class="modal fade" id="modal-default" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="exampleModalLabel">나만의 영상을 등록해보아요!</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form>
            <!-- 제목 입력 -->
            <div class="mb-3">
              <label for="videoTitle" class="form-label">제목</label>
              <input type="text" id="videoTitle" v-model="title" name="title" class="form-control" placeholder="제목을 입력하세요">
            </div>

            <!-- 운동 부위 선택 -->
            <div class="mb-3">
              <label for="part" class="form-label">운동 부위</label>
              <select name="part" v-model="part" id="part" class="form-select">
                <option value="upper">상체</option>
                <option value="lower">하체</option>
                <option value="abdomen">복부</option>
                <option value="whole">전신</option>
              </select>
            </div>

            <!-- URL 입력 -->
            <div class="mb-3">
              <label for="videoUrl" class="form-label">영상 URL</label>
              <input type="text" v-model="url" id="videoUrl" name="url" class="form-control" placeholder="URL을 입력하세요">
            </div>
          </form>
        </div>

        <div class="modal-footer">
          <button type="button" id="modalClose" class="btn btn-primary" @click="enroll">등록</button>
          <button type="button" id="modalClose" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
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
          <a :href="`/review?videoId=${exer.id}`">{{ exer.title }}</a>
        </div>
        <div class="row" id="조회수">
          <a :href="`/review?videoId=${exer.id}`">{{ exer.count }}</a>
        </div>
        <div class="row" id="작성자">
          <a :href="`/review?videoId=${exer.id}`">{{ exer.writer }}</a>
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
          <a :href="`/review?videoId=${exer.id}`">{{ exer.title }}</a>
        </div>
        <div class="row" id="조회수">
          <a :href="`/review?videoId=${exer.id}`">{{ exer.count }}</a>
        </div>
        <div class="row" id="작성자">
          <a :href="`/review?videoId=${exer.id}`">{{ exer.writer }}</a>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, computed, onMounted } from 'vue'
import '@/assets/main.css'
import { getVideoList, insertVideo } from "@/api/video"
import { useRouter } from 'vue-router'
import { useLoginCheck } from '@/stores/logincheck'

// 상태 변수들
const selectedPart = ref("all")
const exers = ref([])
const title = ref("")
const part = ref("")
const url = ref("")

const router = useRouter()

const loginCheck = useLoginCheck();
loginCheck.checkLogin();

// 비디오 리스트 요청
const requestBoardList = async () => {
  exers.value = await getVideoList()
}

const insertVideoModal = async () => {
  if(!sessionStorage.getItem("id")) {
    alert("로그인 후 영상 등록이 가능합니다.");
    return;
  }
  const video = {
    title: title.value,
    part: part.value,
    url: url.value,
    writer: sessionStorage.getItem("name"),
    writerId: sessionStorage.getItem("id"),
  }
  await insertVideo(video)
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
const enroll = () => {
  console.log(title.value);
  console.log(part.value);
  console.log(url.value);

  insertVideoModal()
  router.replace('/')
  window.location.reload();
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