import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

import * as actions from '@/js/stores/actions.js';
import * as getters from '@/js/stores/getters.js';
import * as mutations from '@/js/stores/mutations.js';

// const uiState = createPersistedState({
//     paths: ['ui.showSubscription'],
//     key: 'ui'
// })

// Main Store
export const store = createStore({
    namespaced: true,
    state: {
        csrf: null,
        gqlToken: null,
        news: null,
    },
    getters,
    mutations,
    actions,
    modules: {},
    // plugins: [uiState],
});
