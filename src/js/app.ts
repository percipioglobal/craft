import App from '@/vue/App.vue'
import { createApp } from 'vue'

// Import font awesome icons
import './assets/icons'

// Import our CSS
import '@/css/app.pcss'

// App main
const main = async () => {
    const app = createApp(App)
    return app.mount('#app-container')
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
