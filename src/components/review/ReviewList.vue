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
.container-body {
  background-color: #0a0f1a;
  color: #e6ecff;
  padding: 2rem;
  min-height: 100vh;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.review {
  max-width: 900px;
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.2rem;
  color: #3399ff;
}

h1, h2, h5 {
  color: #3399ff;
  margin: 0.5rem 0;
  text-align: center;
}

.exercisegif {
  width: 120px;
  height: 80px;
  background-color: #1a2238;
  border-radius: 10px;
  background-image: url('https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExamJ6NTA5azl6dTA2MDlocjEyanFrcnV4ODVqeHpnYjFpNzNranZnaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/huyj8anewApiD8cVFu/giphy.gif'); /* 실제 gif 들어갈 자리 */
  background-size: cover;
  background-position: center;
}

.iframe {
  max-width: 720px;
  margin: 1rem auto;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 0 30px #007bff44;
}

.container {
  max-width: 900px;
  margin-top: 2rem;
  background: #121a36;
  border-radius: 14px;
  padding: 1.5rem 2rem;
  box-shadow: 0 0 30px #3399ff33;
  display: flex;
  flex-direction: column;
}

input[type="submit"], button {
  background-color: #007bff;
  border: none;
  color: white;
  font-weight: 600;
  padding: 0.6rem 1.5rem;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
  box-shadow: 0 0 8px #007bff88;
}

input[type="submit"]:hover, button:hover {
  background-color: #0056cc;
  transform: translateY(-1px);
}

h5 {
  margin-top: 0.5rem;
  text-align: center;
  font-weight: 500;
  color: #a0bfff;
  font-style: italic;
}

.list-header {
  background-color: #1b2b50;
  color: #80bfff;
  font-weight: 600;
  padding: 10px 16px;
  display: grid;
  grid-template-columns: 1fr 6fr 2fr 1fr 4fr;
  border-radius: 10px 10px 0 0;
}

.list {
  display: grid;
  grid-template-columns: 1fr 6fr 2fr 1fr 4fr;
  padding: 12px 16px;
  border-bottom: 1px solid #223355;
  color: #dce3ff;
  transition: background-color 0.2s ease;
}

.list:hover {
  background-color: #1d2b4a;
  cursor: pointer;
  border-radius: 0 0 10px 10px;
}

.subject a {
  color: #a8ccff;
  text-decoration: none;
  font-weight: 500;
}

.subject a:hover {
  text-decoration: underline;
  color: #ffffff;
}

.locked-message {
  font-weight: 600;
  color: #66a3ff;
  font-style: italic;
  font-size: 0.95rem;
  padding-left: 4px;
}

/* 반응형 개선 */
@media (max-width: 768px) {
  .list, .list-header {
    grid-template-columns: 1fr 4fr 2fr 1fr 3fr;
  }

  .iframe iframe {
    height: 230px;
  }
}
</style>


