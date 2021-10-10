import App from '@/vue/App.vue'
import { createApp } from 'vue'
import { store } from './stores/store.js'

// App main
const main = async () => {

    // Async load the vue module
    const [Vue, Lazysizes] = await Promise.all([
        import(/* webpackChunkName: "vue" */ 'vue'),
        import(/* webpackChunkName: "lazysizes" */ 'lazysizes'),
    ]).then(arr => arr.map(({ default: defaults }) => defaults));

    const app = createApp(App)

    // Mount Vuex
    app.use(store)

    // Mount the app
    const root = app.mount('#page-container')

    return root
}

// Execute async function
main().then((root) => { });

// Accept HMR as per: https://webpack.js.org/api/hot-module-replacement#accept
if (module.hot) {
    module.hot.accept();
}
