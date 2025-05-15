import { createRouter, createWebHistory } from 'vue-router'
import VideoView from "@/views/VideoView.vue";
import Main from "@/components/video/Main.vue";
import Login from "@/components/user/Login.vue";
import UserView from "@/views/UserView.vue";
import Signup from "@/components/user/Signup.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'videoView',
      component: VideoView,
      children: [
        {
          path: '',
          name: 'main',
          component:  Main,
        }
      ]
    },
    {
      path: '/user',
      name: 'user',
      component:  UserView,
      children: [
        {
          path: 'login',
          name: 'login',
          component:  Login,
        },
        {
          path: 'signup',
          name: 'signup',
          component:  Signup,
        },
      ]
    }
  ],
})

export default router