<template>
  <div class="chat-window">
    <div class="header">
      <span>💬 챗봇</span>
      <button @click="$emit('close')">×</button>
    </div>
    <div class="messages" ref="messages">
      <div v-for="(msg, i) in messages" :key="i" :class="['message', msg.from]">
        {{ msg.text }}
      </div>
    </div>
    <div class="input-area">
      <input type="text" v-model="input" @keyup.enter="sendMessage" :disabled="isBlocked || isLoading" placeholder="메시지를 입력하세요" />
      <button @click="sendMessage" :disabled="isBlocked || isLoading">전송</button>
    </div>
  </div>
</template>

<script>
import { useLoginCheck } from '@/stores/logincheck'
import { useSubscribeCheck } from '@/stores/subscribe'
import { chatWithGPT } from '@/api/gpt'

export default {
  data() {
    return {
      input: '',
      messages: [],
      useCount: 0,
      isBlocked: false,
      isLoading: false
    }
  },
  computed: {
    loginCheck() {
      return useLoginCheck()
    },
    subscribeCheck() {
      return useSubscribeCheck()
    },
    userId() {
      return this.loginCheck.userId
    },
    isSubscribed() {
      return this.subscribeCheck.isSubscribed
    }
  },
  mounted() {
    this.loadChatState()

    this.sessionInterval = setInterval(() => {
      if (this.loginCheck.isLoggedIn && !this.isBlocked) {
        // 로그인 유지 중이면 차단 해제 가능성 체크
        if (this.useCount < 3 || this.isSubscribed) {
          this.isBlocked = false
          if (!this.messages.find(m => m.text.includes('채팅이 가능합니다'))) {
            this.messages.push({ from: 'bot', text: '✅ 로그인 상태가 확인되어 채팅이 가능합니다.' })
          }
        }
      } else {
        this.isBlocked = true
      }
    }, 2000)
  },
  beforeUnmount() {
    clearInterval(this.sessionInterval)
  },
  methods: {
    loadChatState() {
      // sessionStorage에서 메시지 및 사용횟수 불러오기
      const savedMsgs = JSON.parse(sessionStorage.getItem('chatMessages') || '[]')
      if (savedMsgs.length) this.messages = savedMsgs

      const savedCount = parseInt(sessionStorage.getItem('useCount'))
      if (!isNaN(savedCount)) this.useCount = savedCount

      // 로그인 안 됐으면 차단
      if (!this.loginCheck.isLoggedIn) {
        alert('접근 권한이 없습니다. 로그인 후 이용해주세요.')
        this.isBlocked = true
        return
      }

      // 무료 사용 횟수 초과시 차단 (구독자는 무제한)
      if (this.useCount >= 3 && !this.isSubscribed) {
        this.isBlocked = true
        if (!this.messages.find(m => m.text.includes('무료 사용 횟수를 초과'))) {
          this.messages.push({ from: 'bot', text: '⚠️ 무료 사용 횟수를 초과했습니다.' })
        }
      }
    },

    async sendMessage() {
      if (!this.input.trim() || this.isBlocked) return

      const userMsg = this.input.trim()
      this.messages.push({ from: 'user', text: userMsg })
      this.input = ''
      this.useCount++
      sessionStorage.setItem('useCount', this.useCount)

      if (this.useCount >= 3 && !this.isSubscribed) {
        this.isBlocked = true
        this.messages.push({ from: 'bot', text: '⚠️ 무료 사용 횟수를 초과했습니다.' })
        return
      }

      this.isLoading = true
      try {
        const formattedMessages = this.messages
          .filter(m => m.from === 'user' || m.from === 'bot')
          .map(m => ({
            role: m.from === 'user' ? 'user' : 'assistant',
            content: m.text
          }))

        const reply = await chatWithGPT([
          { role: 'system', content: 'You are a helpful assistant.' },
          ...formattedMessages
        ])
        this.messages.push({ from: 'bot', text: reply })
      } catch (err) {
        console.error(err)
        let errorMsg = '⚠️ GPT 호출 중 오류가 발생했습니다.'
        if (err.response) {
          if (err.response.status === 401) errorMsg = '❌ 유효하지 않은 API 키입니다.'
          else if (err.response.status === 429) errorMsg = '📈 호출 제한을 초과했습니다. 잠시 후 다시 시도해주세요.'
          else errorMsg = `⚠️ 서버 오류 (${err.response.status})`
        } else if (err.request) {
          errorMsg = '⏱️ GPT 서버로부터 응답이 없습니다. 네트워크를 확인해주세요.'
        } else {
          errorMsg = `⚠️ 오류 발생: ${err.message}`
        }
        this.messages.push({ from: 'bot', text: errorMsg })
      } finally {
        this.isLoading = false
        this.$nextTick(() => {
          this.$refs.messages.scrollTop = this.$refs.messages.scrollHeight
        })
        sessionStorage.setItem('chatMessages', JSON.stringify(this.messages))
      }
    }
  }
}
</script>

<style scoped>
.chat-window {
  position: fixed;
  bottom: 100px;
  right: 24px;
  width: 300px;
  height: 400px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
  display: flex;
  flex-direction: column;
  z-index: 1001;
  overflow: hidden;
}
.header {
  background: #007bff;
  color: white;
  padding: 10px;
  font-weight: bold;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.messages {
  flex: 1;
  padding: 10px;
  overflow-y: auto;
  max-height: 400px;
  background: #f5f5f5;
}

.message {
  display: block;      /* inline-block -> block 으로 변경 */
  padding: 8px 12px;
  margin: 6px 0;
  border-radius: 16px;
  max-width: 80%;
  word-wrap: break-word;
  white-space: normal;
  clear: both;         /* 이전 플로팅 요소 없애기 */
}

.message.user {
  background-color: #007bff;
  color: white;
  align-self: flex-end;
  margin-left: auto;    /* 오른쪽 정렬 */
  border-bottom-right-radius: 0;
}

.message.bot {
  background-color: #e5e5ea;
  color: black;
  align-self: flex-start;
  margin-right: auto;    /* 오른쪽 정렬 */
  border-bottom-left-radius: 0;
}
.input-area {
  display: flex;
  padding: 8px;
  border-top: 1px solid #ddd;
  background: #fff;
}
.input-area input {
  flex: 1;
  padding: 6px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
.input-area button {
  margin-left: 6px;
  padding: 6px 12px;
  background: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
}
</style>
