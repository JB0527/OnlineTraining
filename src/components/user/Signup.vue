<template>
  <div class="container-box">
    <div class="title">회원가입</div>

    <form action="${contextRoot}/user" method="post">
      <input type="hidden" name="action" value="signup" />
      <div class="input-box">
        <div>
          <label for="id">아이디</label>
          <input id="id" name="id" placeholder="아이디를 입력해주세요" />
        </div>
        <div>
          <label for="name">이름</label><input id="name" name="name" placeholder="이름을 입력해주세요" />
        </div>
        <div>
          <label for="email">이메일</label><input type="email" id="email" name="email" placeholder="이메일을 입력해주세요" />
        </div>
        <div>
          <label for="password">비밀번호</label><input type="password" id="password" name="password"
            placeholder="비밀번호를 입력해주세요" />
        </div>
        <div>
          <label for="pscheck">비밀번호 확인</label><input type="password" id="pscheck" placeholder="비밀번호를 입력해주세요" />
        </div>
      </div>
      <hr />
      <div class="button-box">
        <button class="signup">가입</button>
        <div class="explain-text"> 이미 아이디가 있으시다면?</div>
      </div>
    </form>
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
const password = ref('');
const pscheck = ref('');

const requestSignup = async () => {
  await signup({

  })
}

const requestSignin = () => {
  router.push('/user/login');
}
</script>

<style scoped></style>