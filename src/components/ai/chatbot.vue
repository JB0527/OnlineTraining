<template>
  <div>
    <div class="chatbot-button" @click="toggleChat">💬</div>
    <ChatWindow v-if="isOpen" @close="toggleChat" />
  </div>
</template>

<script>
import ChatWindow from './ChatWindow.vue'

export default {
  components: { ChatWindow },
  data() {
    return { isOpen: false }
  },
  methods: {
    toggleChat() {
      this.isOpen = !this.isOpen
    }
  }
}
</script>

<style scoped>
.chatbot-button {
  position: fixed;
  bottom: 24px;
  right: 24px;
  width: 60px;
  height: 60px;
  background-color: #007bff;
  color: white;
  border-radius: 50%;
  font-size: 28px;
  text-align: center;
  line-height: 60px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  cursor: pointer;
  z-index: 1000;
  transition: transform 0.2s ease;
}
.chatbot-button:hover {
  transform: scale(1.1);
}
</style>
