import App from '~/vue/App.vue'
import { createApp, h } from 'vue'
import { createPinia } from 'pinia'

import '@/css/app.pcss'

const main = async () => {
    const app = createApp({
        render: () => h(App)
    })
    app.use(createPinia())

    return app.mount('#page-container')
}

main().then(() => {
    console.log()
})

// Accept HMR as per: https://vitejs.dev/guide/api-hmr.html
if (import.meta.hot) {
    import.meta.hot.accept(() => {
        console.log("HMR")
    });
}
