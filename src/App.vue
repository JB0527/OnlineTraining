<template>
  <div>
    <!-- 헤더 -->
    <header>
      <Header />
      
      
    </header>

    <!-- 검색창 -->
    <main>
      <ChatBot />
      <RouterLink to="/"></RouterLink>
      <RouterView />

    </main>
    
    <footer>
      <Footer />
    </footer>

  </div>
</template>

<script setup>
import Header from '@/components/section/Header.vue';
import Footer from '@/components/section/Footer.vue';
import RecommendView from '@/views/RecommendView.vue';
import ChatBot from './components/ai/chatbot.vue';

</script>

