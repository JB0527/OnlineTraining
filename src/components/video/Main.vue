<template>
  <!-- 로그인 상태일 때만 등록 버튼 표시 -->
  <div class="container my-4" v-if="loginCheck.isLoggedIn">
    <button type="button" class="btn btn-primary rounded-pill px-4 py-2" data-bs-toggle="modal" data-bs-target="#uploadModal">
      🎬 영상 등록하기
    </button>
  </div>

  <!-- 영상 등록 모달 -->
  <div class="modal fade" id="uploadModal" tabindex="-1" aria-labelledby="uploadModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content dark-modal">
        <div class="modal-header border-bottom-0">
          <h5 class="modal-title" id="uploadModalLabel">나만의 영상 등록</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form>
            <div class="mb-3">
              <label for="videoTitle" class="form-label">제목</label>
              <input type="text" v-model="title" id="videoTitle" class="form-control" placeholder="영상 제목 입력" />
            </div>
            <div class="mb-3">
              <label for="part" class="form-label">운동 부위</label>
              <select v-model="part" id="part" class="form-select">
                <option value="upper">상체</option>
                <option value="lower">하체</option>
                <option value="abdomen">복부</option>
                <option value="whole">전신</option>
              </select>
            </div>
            <div class="mb-3">
              <label for="videoUrl" class="form-label">영상 URL</label>
              <input type="text" v-model="url" id="videoUrl" class="form-control" placeholder="YouTube URL 입력" />
            </div>
          </form>
        </div>
        <div class="modal-footer border-top-0 d-flex justify-content-between">
          <button class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
          <button class="btn btn-primary" @click="enroll">등록</button>
        </div>
      </div>
    </div>
  </div>

  <!-- 최근 영상 -->
  <div class="container mt-5">
    <h4 class="section-title">🔥 조회수 TOP </h4>
    <div class="row g-4">
      <div class="col-md-4" v-for="(exer, index) in exersDesc.slice(0, 3)" :key="index">
        <div class="video-card p-3">
          <div class="ratio ratio-16x9 mb-2">
            <iframe :src="exer.url" allowfullscreen style="filter: blur(10px);"  v-if="!subscribeCheck.isSubscribed"></iframe>
            <iframe :src="exer.url" allowfullscreen v-else></iframe>
          </div>
          <h6 class="text-light mb-1">
            <a :href="`/review?videoId=${exer.id}`">{{ exer.title }}</a>
          </h6>
          <div class="text-muted small">조회수: {{ exer.count }} · 작성자: {{ exer.writer }}</div>
        </div>
      </div>
    </div>
  </div>

  <!-- 운동 부위 선택 -->
  <div class="container mt-5">
    <h4 class="section-title">🏋️ 운동 부위 선택</h4>
    <div class="mb-4 d-flex gap-3 flex-wrap">
      <a href="#" @click.prevent="selectedPart = 'all'" class="filter-btn">전체</a>
      <a href="#" @click.prevent="selectedPart = 'whole'" class="filter-btn">전신</a>
      <a href="#" @click.prevent="selectedPart = 'upper'" class="filter-btn">상체</a>
      <a href="#" @click.prevent="selectedPart = 'lower'" class="filter-btn">하체</a>
      <a href="#" @click.prevent="selectedPart = 'abdomen'" class="filter-btn">복부</a>
    </div>

    <div class="row g-4">
      <div class="col-md-4" v-for="(exer, index) in filteredExers" :key="index">
        <div class="video-card p-3">
          <div class="ratio ratio-16x9 mb-2">
            <iframe :src="exer.url" allowfullscreen style="filter: blur(10px);" v-if="!subscribeCheck.isSubscribed"></iframe>
            <iframe :src="exer.url" allowfullscreen v-else></iframe>
          </div>
          <h6 class="text-light mb-1">
            <a :href="`/review?videoId=${exer.id}`">{{ exer.title }}</a>
          </h6>
          <div class="text-muted small">조회수: {{ exer.count }} · 작성자: {{ exer.writer }}</div>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, computed, onMounted } from 'vue'
import { getVideoList, insertVideo, getVideoListDesc } from "@/api/video"
import { useRouter } from 'vue-router'
import { useLoginCheck } from '@/stores/logincheck'
import { useSubscribeCheck } from '@/stores/subscribe'
import '@/assets/video.css';

// 상태 변수들
const selectedPart = ref("all")
const exers = ref([])
const exersDesc = ref([])
const title = ref("")
const part = ref("")
const url = ref("")

const router = useRouter()

const loginCheck = useLoginCheck();
loginCheck.checkLogin();

const subscribeCheck = useSubscribeCheck();
subscribeCheck.checkSubscribe();

// 비디오 리스트 요청
const requestBoardList = async () => {
  exers.value = await getVideoList()
}

const requestBoardListDesc = async () => {
  exersDesc.value = await getVideoListDesc()
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
  requestBoardList();
  requestBoardListDesc();
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