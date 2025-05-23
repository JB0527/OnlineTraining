<template>
  <div class="container-body">
    <div class="review">
      <div class="exercisegif"></div>
      <div>
        <h1>운동영상 리뷰</h1>
      </div>
      <div class="exercisegif"></div>
    </div>
    
    
  
    <h2>{{video.title}}</h2>
    <p>{{video.count }}</p>
    <p>{{video.writer }}</p>
    
    
    <hr>
    <div class="iframe">
      <iframe
        width="560"
        height="315"
        :src="video.url"
        title="YouTube video player"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
        referrerpolicy="strict-origin-when-cross-origin"
        allowfullscreen>
      </iframe>
    </div>



    <hr>
    <div class="container">

      <div class="first">

          <RouterLink :to="{ name: 'reviewWrite', query: { videoId } }">
            <input type="submit" value="리뷰 작성" v-if="subscribeCheck.isSubscribed">
          </RouterLink>
          <button @click="isPossibleDelete">영상 삭제</button>
        </div>

      <h5 style="font-weight: 600; color: #3c526b;">로그인 후 구독해야 리뷰 작성이 가능합니다.</h5>


      <div class="end">



      </div>
      <hr>

      <!-- 헤더 -->
      <div class="list list-header">
        <div class="num">번호</div>
        <div class="subject">제목</div>
        <div class="writer">작성자</div>
        <div class="click">조회수</div>
        <div class="time">작성시간</div>
      </div>

      <!-- 리스트 -->
      <div
        v-for="review in reviews"
        :key="review.reviewId"
        class="list"
      >
        <div class="num">{{ review.reviewId }}</div>
        <div class="subject" v-if="subscribeCheck.isSubscribed">
          <RouterLink :to="{ name: 'reviewDetail', query: { videoId }, params: { reviewId: review.reviewId } }">
            {{ review.title }}
          </RouterLink>
        </div>
        <div class="subject" v-else>
  <p class="locked-message">
    🔒 구독 후 전체 내용을 확인하실 수 있어요!
  </p>
</div>

        <div class="writer">{{ review.writer }}</div>
        <div class="click">{{ review.clickCount }}</div>
        <div class="time">{{ review.writedTime }}</div>
      </div>

    </div>
  </div>

</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { getAllReviews, getSearchReviews } from '@/api/review';
import { deleteVideo, getVideoDetail, updateClickCount } from '@/api/video'
import '@/assets/review.css'
import { useSubscribeCheck } from '@/stores/subscribe';

const route = useRoute();
const videoId = route.query.videoId;
const content = ref('');
const reviews = ref([]);
const video = ref({});
const videoUrl = ref('')
const videoWriter = ref('');
const router = useRouter();
const subscribeCheck = useSubscribeCheck();

subscribeCheck.checkSubscribe();

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

const getVideo = async () => {
  video.value = await getVideoDetail(videoId);
  videoUrl.value = video.value.url
  videoWriter.value = video.value.writerId;
}

const isPossibleDelete = () => {
  if(videoWriter.value !== sessionStorage.getItem("id")) {
    alert("작성자가 아닙니다.")
  } else {
    requestDeleteVideo();
  }
}

const requestDeleteVideo = async () => {
  await deleteVideo(videoId);
  await router.push("/");
}


onMounted(async () => {
  loadAll();
  getVideo();
  if (videoId) {
    updateClickCount(videoId);
  } else {
    console.warn('videoId가 정의되지 않았습니다.');
  }
})


</script>

<style scoped>
.list {
  display: grid;
  grid-template-columns: 1fr 6fr 2fr 1fr 4fr; /* 제목(6fr)과 시간(4fr) 널널하게 */
  padding: 8px 12px;
  border-bottom: 1px solid #ccc;
  align-items: center;
}

.list-header {
  font-weight: bold;
  background-color: #f0f0f0;
}

.subject a {
  color: blue;
  text-decoration: underline;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.time {
  white-space: nowrap;
}


.locked-message {
  margin: 0;
  font-weight: 500;
  line-height: 1.6;
}

</style>
