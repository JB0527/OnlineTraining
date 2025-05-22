<template>
  <div>
    <main class="container-box">
      <div class="title">로그인</div>

      <div>
        <input type="hidden" name="action" value="login"/>
        <div class="input-box">
          <div>
            <label for="id">아이디</label><input v-model="userId" id="id" name="id" placeholder="아이디를 입력해주세요"/>
          </div>
          <div>
            <label for="password">비밀번호</label><input v-model="password" type="password" name="password" id="password"
                                                     class="password" placeholder="비밀번호를 입력해주세요"/>
          </div>
        </div>
        <div>
          <hr/>
          <p style="font-size: 12px; color: red; text-align: center">{{ message }}</p>
        </div>

        <div class="button-box">
          <button class="signin" @click="login">로그인</button>
          <div class="explain-text">아직 회원이 아니신가요?</div>
        </div>
      </div>
      <button class="signup" @click="signup">회원가입</button>
    </main>
  </div>
</template>

<script setup>
import '@/assets/signin.css'
import {useRouter} from 'vue-router'
import {ref} from "vue";
import axios from "axios";
import { useLoginCheck } from '@/stores/logincheck'

const userId = ref('')
const password = ref('')
const message = ref("")

const router = useRouter()
const logincCheck = useLoginCheck();

const signup = () => {
  router.push('/user/signup')
}

const BASE_URL = "http://localhost:8080/api/v1"

const login = async () => {
  await axios.post(BASE_URL + "/user/login", {
    id: userId.value,
    password: password.value,
  }).then((res) => {
    if (res.status === 200) {
      console.log(res.data)
      logincCheck.login(res.data.id, res.data.name);
      router.push('/')
    } else {
      message.value = "아이디나 비밀번호가 일치하지 않습니다."
    }
  }).catch((err) => {
    console.log(err)
  })
}

</script>

<style scoped>

</style>