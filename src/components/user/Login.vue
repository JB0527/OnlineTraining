<template>
  <div>
    <main class="container-box">
      <div class="title">로그인</div>

      <form action="/user" method="post">
        <input type="hidden" name="action" value="login"/>
        <div class="input-box">
          <div>
            <label for="id">아이디</label><input id="id" name="id" placeholder="아이디를 입력해주세요"/>
          </div>
          <div>
            <label for="password">비밀번호</label><input type="password" name="password" id="password"
                                                     class="password" placeholder="비밀번호를 입력해주세요"/>
          </div>
        </div>
        <div>
          <hr/>
        </div>

        <div class="button-box">

          <button class="signin">로그인</button>
          <div class="explain-text">아직 회원이 아니신가요?</div>
        </div>
      </form>
      <button class="signup" @click="signup">회원가입</button>
    </main>
  </div>
</template>

<script setup>
import '@/assets/signin.css'
import {useRouter} from 'vue-router'

const router = useRouter()
const signup = () => {
  router.push('/user/signup')
}
</script>

<style scoped>

</style>