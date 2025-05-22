<template>
  <div class="review-write">
    <h2>리뷰 작성</h2>
    <form @submit.prevent="submit">
      <input v-model="title" type="text" placeholder="제목" required />
      <textarea v-model="content" placeholder="내용" required></textarea>
      <button type="submit">작성하기</button>
      
        <!-- 에러 메시지 -->
      <p v-if="errorMsg" style="color: red; margin-top: 10px;">
        {{ errorMsg }}
      </p>
    </form>
  </div>
</template>
<script setup>
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { writeReview } from '@/api/review'

const route = useRoute()
const router = useRouter()
const errorMsg = ref('');

const videoId = route.query.videoId
const title = ref('')
const content = ref('')
const now = new Date();
const writedTime = now.toISOString().slice(0, 19).replace('T', ' '); 

const submit = async () => {
  errorMsg.value = '';  // 초기화

  try {
    const writerId = sessionStorage.getItem('id');
    const writer = sessionStorage.getItem('name');

    if (!writerId) {
      throw new Error("로그인 정보가 없습니다.");
    }

    await writeReview({
      videoId,
      title: title.value,
      content: content.value,
      writer,
      writerId,
      writedTime
    });

    router.push({ name: 'reviewList', query: { videoId } });
  } catch (e) {
    // e.response?.data가 있으면 그걸로, 없으면 e.message로
    errorMsg.value = e.response?.data || e.message || "작성 실패했습니다.";
    console.error("작성 실패", e.response?.data || e.message);
  }
};
</script>