<template>
  <div class="container d-flex justify-content-center align-items-center py-5">
    <div class="subscribe-card p-5 text-center">
      <h1 class="subscribe-title mb-3">🎉 Subscribe</h1>
      <p class="subscribe-description mb-4">
        좋아하는 영상의 리뷰를 감상하고,<br>
        더 깊이 느껴보세요.<br><br>
        <strong>단돈 1,000원</strong>으로 모든 서비스를 누릴 수 있어요!<br>
        <span class="text-muted" style="font-size: 0.9rem;">* 결제는 <strong>네이버페이</strong>로만 가능합니다 😊</span>
      </p>

      <!-- 네이버페이 버튼 -->
      <div class="mb-3">
        <img
          style="cursor: pointer; max-width: 200px"
          src="../../assets/images/btn_rd_npaygr_paying.svg"
          id="naverPayBtn"
          alt="네이버페이 결제하기"
        />
      </div>

      <!-- 네이버페이 스크립트용 버튼 영역 -->
      <div>
        <div id="naverPayButton"></div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted } from 'vue'

onMounted(() => {
  // 네이버페이 SDK 동적 로딩
  const script = document.createElement('script')
  script.src = 'https://nsp.pay.naver.com/sdk/js/naverpay.min.js'
  script.onload = async () => {
    const oPay = window.Naver?.Pay?.create({
      mode: 'development', // 또는 'production'
      clientId: 'HN3GGCMDdTgGUfl0kFCo', // 네이버페이에서 발급받은 clientId
      chainId: 'ck5CL2hEU0dZWUh'     // optional, 필요 시 입력
    })

    const elNaverPayBtn = document.getElementById('naverPayBtn')

    elNaverPayBtn?.addEventListener('click', async () => {
      try {
        // (선택) 백엔드에서 merchantPayKey 생성 요청
        await oPay.open({
          merchantPayKey: "20250523HADvwY",
          productName: "온라인트레이닝 구독료",
          totalPayAmount: 1000,
          productCount: 1,
          taxScopeAmount: 1000,
          taxExScopeAmount: 0,
          "returnUrl": "http://70.12.50.190:5173/payment/complete"
        })
      } catch (err) {
        console.error('네이버페이 호출 실패:', err)
      }
    })
  }
  document.head.appendChild(script);

})


</script>

<style scoped>
body {
  background-color: #121212;
  color: #ffffff;
  font-family: 'Noto Sans KR', sans-serif;
}

.subscribe-card {
  background-color: #1f1f1f;
  border-radius: 16px;
  max-width: 500px;
  width: 100%;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.5);
}

.subscribe-title {
  color: #64b5f6;
  font-weight: 700;
  font-size: 2rem;
}

.subscribe-description {
  color: #e0e0e0;
  font-size: 1.1rem;
  line-height: 1.6;
}
</style>
