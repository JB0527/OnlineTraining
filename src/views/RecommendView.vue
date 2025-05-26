<template>
  <div class="recommend-container">
    <input
      v-model="userInput"
      placeholder="운동 목적을 입력하세요 (예: 근력, 유산소)"
      class="input-box"
    />
    <button @click="getRecommendation" class="recommend-button">
      추천 받기
    </button>

    <div v-if="videoLinks.length" class="result-section">
      <h3>🔗 추천 영상 목록:</h3>
      <ul>
        <li v-for="(link, index) in videoLinks" :key="index">
          <a :href="link" target="_blank">{{ link }}</a>
        </li>
      </ul>
    </div>

    <div v-if="responseText" class="response-text">
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
.recommend-container {
  max-width: 700px;
  margin: 40px auto;
  background: #0d1117; /* 짙은 블랙 느낌 */
  padding: 30px 40px;
  border-radius: 10px;
  box-shadow: 0 0 15px #1f6feb88; /* 블루 글로우 느낌 */
  color: #c9d1d9; /* 연한 회색 - 가독성 좋음 */
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  user-select: none;
}

.input-box {
  width: 70%;
  padding: 12px 15px;
  font-size: 1rem;
  border: 2px solid #1f6feb;
  border-radius: 6px 0 0 6px;
  outline: none;
  color: #0d1117;
  font-weight: 600;
}

.input-box::placeholder {
  color: #6b778c; /* 연한 블루/그레이 */
}

.recommend-button {
  padding: 12px 20px;
  font-size: 1rem;
  background-color: #1f6feb;
  border: none;
  border-radius: 0 6px 6px 0;
  color: white;
  font-weight: 700;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.recommend-button:hover {
  background-color: #54a0ff;
}

.result-section {
  margin-top: 30px;
}

.result-section h3 {
  color: #58a6ff;
  margin-bottom: 15px;
  font-weight: 700;
  border-bottom: 2px solid #1f6feb;
  padding-bottom: 6px;
}

.result-section ul {
  list-style-type: none;
  padding-left: 0;
}

.result-section li {
  margin-bottom: 10px;
}

.result-section a {
  color: #1f6feb;
  text-decoration: none;
  font-weight: 600;
  word-break: break-all;
}

.result-section a:hover {
  text-decoration: underline;
}

.response-text {
  margin-top: 30px;
  background-color: #161b22;
  border: 1px solid #30363d;
  padding: 15px;
  border-radius: 8px;
  font-size: 0.95rem;
  color: #8b949e;
  white-space: pre-wrap;
  line-height: 1.4;
  font-family: 'Courier New', Courier, monospace;
  user-select: text;
}
</style>
