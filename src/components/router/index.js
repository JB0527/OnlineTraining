import { createRouter, createWebHistory } from 'vue-router'
import VideoView from "@/views/VideoView.vue";
import Main from "@/components/video/Main.vue";
import Login from "@/components/user/Login.vue";
import UserView from "@/views/UserView.vue";
import Signup from "@/components/user/Signup.vue";

import ReviewView from "@/views/ReviewView.vue"
import ReviewList from "@/components/review/ReviewList.vue"
import ReviewDetail from "@/components/review/ReviewDetail.vue"
import ReviewWrite from "@/components/review/ReviewWrite.vue"
import ReviewUpdate from "@/components/review/ReviewUpdate.vue"
// import ReviewSearch from "@/components/review/ReviewSearch.vue"

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
    },
    {
      path: '/review',
      name: 'review',
      component: ReviewView,
      children: [
        {
          path: '',
          name: 'reviewList',
          component: ReviewList,
        },
        // {
        //   path: 'search',
        //   name: 'reviewSearch',
        //   component: ReviewSearch
        // },
        {
          path: ':id',
          name: 'reviewDetail',
          component: ReviewDetail,
          props: true
        },
        {
          path: 'write/:videoId',
          name: 'reviewWrite',
          component: ReviewWrite,
          props: true
        },
        {
          path: 'update/:id',
          name: 'reviewUpdate',
          component: ReviewUpdate,
          props: true
        }
      ]
    } 
  ],
})

export default router

