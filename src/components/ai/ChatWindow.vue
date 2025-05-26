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
import { chatWithGPT } from '@/api/gpt'

export default {
  data() {
    return {
      input: '',
      messages: [],
      userId: '',
      isSubscribed: false,
      useCount: 0,
      isBlocked: false,
      isLoading: false
    }
  },
  mounted() {
    this.checkSession()

    // 로그인 감지용 인터벌
    this.sessionInterval = setInterval(() => {
      const userStr = sessionStorage.getItem('userId')
      if (userStr && !this.userId) {
        this.checkSession() // 세션 재확인
        if (this.useCount < 3 || this.isSubscribed) {
          this.isBlocked = false
          this.messages.push({ from: 'bot', text: '✅ 로그인 상태가 확인되어 채팅이 가능합니다.' })
        }
      }
    }, 2000)
  },
  beforeUnmount() {
    clearInterval(this.sessionInterval)
  },
  methods: {
    checkSession() {
      const userStr = sessionStorage.getItem('userId')
      if (userStr) {
        try {
          const userObj = JSON.parse(userStr)
          this.userId = userObj.id || userStr
          this.isSubscribed = userObj.isSubscribed || (sessionStorage.getItem('isSubscribed') === 'true')
        } catch {
          this.userId = userStr
          this.isSubscribed = sessionStorage.getItem('isSubscribed') === 'true'
        }
      } else {
        alert('접근 권한이 없습니다. 로그인 후 이용해주세요.')
        this.isBlocked = true
        return
      }

      const savedMsgs = JSON.parse(sessionStorage.getItem('chatMessages') || '[]')
      if (savedMsgs.length) this.messages = savedMsgs

      const savedCount = parseInt(sessionStorage.getItem('useCount'))
      if (!isNaN(savedCount)) {
        this.useCount = savedCount
        if (this.useCount >= 3 && !this.isSubscribed) {
          this.isBlocked = true
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
            // OpenAI API에서 응답을 받았지만 오류 상태 (예: 401, 429 등)
            if (err.response.status === 401) {
            errorMsg = '❌ 유효하지 않은 API 키입니다.'
            } else if (err.response.status === 429) {
            errorMsg = '📈 호출 제한을 초과했습니다. 잠시 후 다시 시도해주세요.'
            } else {
            errorMsg = `⚠️ 서버 오류 (${err.response.status})`
            }
        } else if (err.request) {
            // 요청은 보냈지만 응답이 없음
            errorMsg = '⏱️ GPT 서버로부터 응답이 없습니다. 네트워크를 확인해주세요.'
        } else {
            // 그 외 에러
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
  background: #f7f7f7;
}
.message {
  margin: 6px 0;
  padding: 8px;
  border-radius: 6px;
  max-width: 90%;
}
.message.user {
  background-color: #e1f0ff;
  align-self: flex-end;
  text-align: right;
}
.message.bot {
  background-color: #eee;
  align-self: flex-start;
  text-align: left;
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
