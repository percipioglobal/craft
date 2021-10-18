import axios from 'axios';
import { configureXhrApi, executeXhr } from '@/js/utils/xhr.js'
import { configureGqlApi, executeGqlQuery } from '@/js/utils/gql.js'

const CSRF_ENDPOINT = '/actions/site-module/csrf/get-csrf'
const TOKEN_ENDPOINT = '/actions/site-module/csrf/get-gql-token'
const GRAPHQL_ENDPOINT = '/api'

// Fetch & commit the CSRF token
export const FETCH_CSRF = async ({ commit }) => {
    const api = axios.create(configureXhrApi(CSRF_ENDPOINT))
    let variables = {
    };
    // Execute the XHR
    await executeXhr(api, variables, (data) => {
        commit('SET_CSRF', data)
    })
}

// Fetch & commit the GraphQL token
export const FETCH_GQL_TOKEN = async ({ commit, state }) => {
    const api = axios.create(configureXhrApi(TOKEN_ENDPOINT));
    let variables = {
        ...(state.csrf && { [state.csrf.name]: state.csrf.value }),
    };
    // Execute the XHR
    await executeXhr(api, variables, (data) => {
        commit('SET_GQL_TOKEN', data)
    })
}