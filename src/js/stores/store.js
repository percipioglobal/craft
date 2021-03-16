import * as actions from '@/js/src/stores/actions.js';
import * as getters from '@/js/src/stores/actions.js';
import * as mutations from '@/js/src/stores/actions.js';

// Main Store
export const createStore = async(Vue) => {
    const { default: Vuex } = await import(/* webpackChunkName: "vuex" */ 'vuex');
    Vue.use(Vuex);
    return new Vuex.Store({
        state: {
            csrf: null,
            gqlToken: null,
            news: null,
        },
        getters,
        mutations,
        actions,
        modules: {}
    })
}