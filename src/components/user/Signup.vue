<template>
  <div class="container-box">
    <div class="title">회원가입</div>

    <input type="hidden" name="action" value="signup" />
    <div class="input-box">
      <div>
        <label for="id">아이디</label>
        <input id="id" name="id" v-model="id" placeholder="아이디를 입력해주세요" />
      </div>
      <div>
        <label for="name">이름</label>
        <input id="name" name="name" v-model="name" placeholder="이름을 입력해주세요" />
      </div>
      <div>
        <label for="email">이메일</label>
        <input type="email" id="email" name="email" v-model="email" placeholder="이메일을 입력해주세요" />
      </div>
      <div>
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" v-model="password" placeholder="비밀번호를 입력해주세요" />
      </div>
      <div>
        <label for="pscheck">비밀번호 확인</label>
        <input type="password" id="pscheck" v-model="pscheck" placeholder="비밀번호를 입력해주세요" />
      </div>
    </div>
    <hr />
    <div class="button-box">
      <button class="signup" @click="pschecking">가입</button>
      <div class="explain-text"> 이미 아이디가 있으시다면?</div>
    </div>
    <button class="signin" @click="requestSignin">로그인
    </button>
  </div>
</template>

<script setup>
import { signup } from '@/api/user'
import { ref } from 'vue'
import router from '../router';
const id = ref('');
const name = ref('');
const email = ref('');
const password = ref('');
const pscheck = ref('');
const data = ref('');

const pschecking = () => {
  if (pscheck.value === password.value) {
    requestSignup();
  } else {
    alert("비밀번호가 일치하지 않습니다.");
  }
}

const requestSignup = async () => {
  data.value = await signup({
    id: id.value,
    name: name.value,
    email: email.value,
    password: password.value,
  });
  if (data.value === 200) {
    await router.push('/user/login');
  } else {
    alert("이미 아이디나 이메일이 존재합니다.");
  }
}

const requestSignin = () => {
  router.push('/user/login');
}
</script>

<style scoped></style>