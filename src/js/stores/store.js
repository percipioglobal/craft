import * as actions from './actions.js';
import * as getters from './getters.js';
import * as mutations from './mutations.js';

// Main Store
export const createStore = async(Vue) => {
    const { default: Vuex } = await import(/* webpackChunkName: "vuex" */ 'vuex');
    const { default: createPersistedState } = await import(/* webpackChunkName: "vuex-persistedstate" */ 'vuex-persistedstate');
    const { default: createMutationsSharer } = await import(/* webpackChunkName: "vuex-shared-mutations" */ 'vuex-shared-mutations');
    Vue.use(Vuex);
    return new Vuex.Store({
        state: {
            csrf: null,
            gqlToken: null,
        },
        getters,
        mutations,
        actions,
        modules: {},
        plugins: [
            createPersistedState(),
            createMutationsSharer({
                predicate: []
            }),
        ]
    })
}