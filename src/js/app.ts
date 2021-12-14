import App from '@/vue/App.vue'
import { createApp } from 'vue'
import { store } from './stores/store.js'

// Import our CSS
import '@/css/app.pcss';

// App main
const main = async () => {

    const app = createApp(App)

    // Mount Vuex
    app.use(store)

    // Mount the app
    const root = app.mount('#page-container')

    return root
}

// Execute async function
main().then((root) => {
});