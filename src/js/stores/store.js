import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

import * as actions from './actions.js'
import * as getters from './getters.js'
import * as mutations from './mutations.js'

/* ----------- AUTH ----------- */
import { TOKENS } from './tokens/tokenStore'

// Main Store
export const store = createStore({
    namespaced: true,
    state: () => ({}),
    getters,
    mutations,
    actions,
    modules: {
        tokens: TOKENS,
    },
});
