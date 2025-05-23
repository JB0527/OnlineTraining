<template>
  <div class="p-4">
    <h2 class="text-xl font-bold">결제 결과 확인 중...</h2>
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { subscribe } from '@/api/user'
import { useRouter, useRoute } from 'vue-router';
import { useSubscribeCheck } from '@/stores/subscribe'

const router = useRouter();
const route = useRoute();

const result = route.query.resultCode;
const subscribeCheck = useSubscribeCheck();
subscribeCheck.checkSubscribe();

onMounted(async () => {
  try {
    // 실제 결제 성공 여부를 서버로부터 검증하거나,
    // 쿼리 파라미터를 기반으로 처리 가능
    if(result === "Success") {
        await requestSubscribe() // 이제 이 시점에서 실행됨!
    } else {
        alert("결제 실패");
        router.replace("/");
    }
    console.log('구독 성공 처리 완료')
  } catch (err) {
    console.error('구독 처리 실패', err)
  }
})

const requestSubscribe = async () => {
  const userId = sessionStorage.getItem("id");
  console.log(userId);
  await subscribe(userId);
  subscribeCheck.isSubscribed = true;
  sessionStorage.setItem("subscribe", true);
  router.replace('/');
}
</script>
