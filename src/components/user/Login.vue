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
import { useSubscribeCheck } from '@/stores/subscribe'

const userId = ref('')
const password = ref('')
const message = ref("")

const router = useRouter()
const logincCheck = useLoginCheck();
const subscribeCheck = useSubscribeCheck();

const signup = () => {
  router.push('/user/signup')
}

// base64url 디코딩 함수 (한글 깨짐 방지)
function base64UrlDecode(str) {
  // base64url -> base64로 변환
  str = str.replace(/-/g, "+").replace(/_/g, "/");
  // 패딩 추가
  while (str.length % 4) {
    str += "=";
  }
  // 디코딩 (한글 지원)
  try {
    return decodeURIComponent(
        Array.prototype.map
            .call(
                atob(str),
                (c) => "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2)
            )
            .join("")
    );
  } catch (e) {
    return atob(str);
  }
}

const BASE_URL = "http://70.12.50.190:8080/api/v1"

const login = async () => {
  await axios.post(BASE_URL + "/user/login", {
    id: userId.value,
    password: password.value,
  }).then((res) => {
    if (res.status === 200) {
      console.log(res.data)
      const token  = res.data.split(".")

      // 이렇게 가져오면 한글 다 깨져..
      // const name = JSON.parse(atob(token[1]))["name"]
      // const id = JSON.parse(atob(token[1]))["id"]

      const payload = JSON.parse(base64UrlDecode(token[1]));
      const id = payload["id"];
      const name = payload["name"];
      const isSubscribed = payload["isSubscribed"];

      logincCheck.login(id, name, res.data);
      subscribeCheck.subscribe(isSubscribed);
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