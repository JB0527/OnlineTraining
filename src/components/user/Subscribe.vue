<template>
  <div class="container">
    <div class="card">
      <h1 class="title">Subscribe</h1>
      <p class="description">
        좋아하는 영상의 리뷰를 감상하고, 더 깊이 느껴보세요.<br>
        단돈 1,000원으로 모든 서비스를 누릴 수 있어요!<br>
        결제는 네이버페이로만 가능합니다 😊
      </p>

      <div>
        <img style="cursor:pointer" src="../../assets/images/btn_rd_npaygr_paying.svg" id="naverPayBtn" class="bg-green-500 text-white px-4 py-2 rounded">
      </div>
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
          "returnUrl": "http://localhost:5173/payment/complete"
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
.container {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background: linear-gradient(to bottom right, #dbeafe, #ddd6fe);
  padding: 20px;
}

.card {
  background-color: white;
  padding: 30px 40px;
  border-radius: 16px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  text-align: center;
  max-width: 400px;
  width: 100%;
}

.title {
  font-size: 24px;
  font-weight: bold;
  color: #1f2937;
  margin-bottom: 16px;
}

.description {
  color: #4b5563;
  font-size: 16px;
  line-height: 1.6;
  margin-bottom: 24px;
  background-color: #f9fafb;
  padding: 16px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}


.subscribe-btn {
  background-color: #3b82f6;
  color: white;
  border: none;
  padding: 12px 24px;
  font-size: 16px;
  border-radius: 12px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  width: 100%;
}

.subscribe-btn:hover {
  background-color: #2563eb;
}

.subscribe-btn.disabled {
  background-color: #9ca3af;
  cursor: not-allowed;
}
</style>
