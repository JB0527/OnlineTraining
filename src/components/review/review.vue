<template>
  <div>
    <Header />

    <section class="review-section">
      <h2 v-if="mode === 'list'">리뷰 목록</h2>
      <h2 v-if="mode === 'detail'">리뷰 상세</h2>
      <h2 v-if="mode === 'form'">{{ form.id ? '리뷰 수정' : '리뷰 작성' }}</h2>

      <!-- 리뷰 목록 -->
      <div v-if="mode === 'list'">
        <table>
          <thead>
            <tr>
              <th>No</th>
              <th>제목</th>
              <th>작성자</th>
              <th>작성일</th>
              <th>조회수</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(review, idx) in reviews" :key="review.id" @click="viewDetail(review.id)" style="cursor:pointer">
              <td>{{ idx + 1 }}</td>
              <td>{{ review.title }}</td>
              <td>{{ review.writer }}</td>
              <td>{{ formatDate(review.regDate) }}</td>
              <td>{{ review.views }}</td>
            </tr>
          </tbody>
        </table>
        <button @click="startWrite">리뷰 작성</button>
      </div>

      <!-- 리뷰 상세 보기 -->
      <div v-if="mode === 'detail' && selectedReview">
        <h3>{{ selectedReview.title }}</h3>
        <p><strong>작성자:</strong> {{ selectedReview.writer }}</p>
        <p><strong>작성일:</strong> {{ formatDate(selectedReview.regDate) }}</p>
        <p><strong>조회수:</strong> {{ selectedReview.views }}</p>
        <p style="white-space: pre-line;">{{ selectedReview.content }}</p>

        <button @click="startEdit">수정</button>
        <button @click="deleteReview(selectedReview.id)">삭제</button>
        <button @click="mode = 'list'">목록</button>
      </div>

      <!-- 리뷰 작성 및 수정 폼 -->
      <div v-if="mode === 'form'">
        <form @submit.prevent="submitForm">
          <table>
            <tr>
              <th>제목</th>
              <td><input type="text" v-model="form.title" maxlength="50" required /></td>
            </tr>
            <tr>
              <th>내용</th>
              <td>
                <textarea v-model="form.content" rows="5" maxlength="1000" required></textarea>
              </td>
            </tr>
            <tr>
              <th>작성자</th>
              <td><input type="text" v-model="form.writer" maxlength="10" required /></td>
            </tr>
          </table>
          <button type="submit">{{ form.id ? '수정 완료' : '작성 완료' }}</button>
          <button type="button" @click="cancel">취소</button>
        </form>
      </div>
    </section>

    <Footer />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import Header from '../section/Header.vue'
import Footer from '../section/Footer.vue'

const mode = ref('list')
const reviews = ref([])
const selectedReview = ref(null)
const form = ref({ id: null, title: '', content: '', writer: '' })

const fetchReviews = async () => {
  const { data } = await axios.get('/api/reviews')
  reviews.value = data
}

const viewDetail = async (id) => {
  const { data } = await axios.get(`/api/reviews/${id}`)
  selectedReview.value = data
  mode.value = 'detail'
}

const startWrite = () => {
  form.value = { id: null, title: '', content: '', writer: '' }
  mode.value = 'form'
}

const startEdit = () => {
  form.value = { ...selectedReview.value }
  mode.value = 'form'
}

const deleteReview = async (id) => {
  if (confirm('정말 삭제하시겠습니까?')) {
    await axios.delete(`/api/reviews/${id}`)
    await fetchReviews()
    mode.value = 'list'
  }
}

const submitForm = async () => {
  if (form.value.id) {
    await axios.put(`/api/reviews/${form.value.id}`, form.value)
  } else {
    await axios.post('/api/reviews', form.value)
  }
  await fetchReviews()
  mode.value = 'list'
}

const cancel = () => {
  mode.value = 'list'
}

const formatDate = (dateStr) => {
  const d = new Date(dateStr)
  return `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`
}

onMounted(() => {
  fetchReviews()
})
</script>

<style scoped>
.review-section {
  max-width: 800px;
  margin: 0 auto;
  padding: 1rem;
}
table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 1rem;
}
th, td {
  border: 1px solid #ccc;
  padding: 0.5rem;
}
th {
  background: #f5f5f5;
}
button {
  margin: 0.25rem;
}
</style>
