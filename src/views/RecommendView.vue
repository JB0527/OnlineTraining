<template>
  <div>
    <input v-model="userInput" placeholder="운동 목적을 입력하세요 (예: 근력, 유산소)" class="input-box" />
    <button @click="getRecommendation" class="recommend-button">추천 받기</button>

    <div v-if="videoLinks.length" style="margin-top: 20px;">
      <h3>🔗 추천 영상 목록:</h3>
      <ul>
        <li v-for="(link, index) in videoLinks" :key="index">
          <a :href="link" target="_blank">{{ link }}</a>
        </li>
      </ul>
    </div>

    <div v-if="responseText" style="margin-top: 20px; white-space: pre-wrap; border: 1px solid #ddd; padding: 10px;">
      <strong>GPT 응답 원문:</strong><br />
      {{ responseText }}
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { fetchYoutubeLinks } from "@/api/recommend";

const userInput = ref("");
const videoLinks = ref([]);
const responseText = ref("");

async function getRecommendation() {
  try {
    const { links, text } = await fetchYoutubeLinks(userInput.value);
    videoLinks.value = links;
    responseText.value = text;
  } catch (e) {
    console.error("추천 실패:", e);
    responseText.value = `에러 발생: ${e.message || e}`;
  }
}
</script>

<style scoped>
.input-box {
  padding: 0.5rem;
  margin-right: 0.5rem;
  width: 300px;
}
.recommend-button {
  padding: 0.5rem 1rem;
}
</style>
