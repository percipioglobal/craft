// import App from '@/vue/App.vue'
// import { createApp } from 'vue'
import './assets/icons'
import { init as initPageAnimation } from './animations/page'

// Import our CSS
import '@/css/app.pcss';

// App main
const main = async () => {
    initPageAnimation()
}

// Execute async function
main().then( () => {
    console.log()
})

// Accept HMR as per: https://vitejs.dev/guide/api-hmr.html
if (import.meta.hot) {
    import.meta.hot.accept(() => {
        console.log('HMR active')
    });
}
