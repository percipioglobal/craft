import * as tokenActions from './tokenActions.js'
import * as tokenGetters from './tokenGetters.js'
import * as tokenMutations from './tokenMutations.js'

export const NAVIGATION = {
    namespaced: true,
    state: () => ({
        csrf: null,
        gql: null,
    }),
    actions: tokenActions,
    getters: tokenGetters,
    mutations: tokenMutations,
}