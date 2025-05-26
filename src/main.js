import { createApp } from 'vue'
import App from './App.vue'
import router from './components/router'

import $ from 'jquery'
import 'bootstrap'
import WOW from 'wowjs'

new WOW.WOW().init();
window.$ = $;
window.jQuery = $;

import { createPinia } from 'pinia'

const app = createApp(App)
const pinia = createPinia();

app.use(router)
app.use(pinia)

app.mount('#app')
