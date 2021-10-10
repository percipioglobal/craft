import axios from 'axios';
import { configureXhrApi, executeXhr } from '@/js/utils/xhr.js';
import { configureGqlApi, executeGqlQuery } from '@/js/utils/gql.js';
import { NEWS_QUERY } from '@/js/data/queries.js';


const CSRF_ENDPOINT = '/actions/site-module/csrf/get-csrf';
const TOKEN_ENDPOINT = '/actions/site-module/csrf/get-gql-token';
const GRAPHQL_ENDPOINT = '/api';

// Fetch & commit the CSRF token
export const FETCH_CSRF = async ({ commit }) => {
    const api = axios.create(configureXhrApi(CSRF_ENDPOINT));
    let variables = {
    };
    // Execute the XHR
    await executeXhr(api, variables, (data) => {
        commit('SET_CSRF', data);
    });
};

// Fetch & commit the GraphQL token
export const FETCH_GQL_TOKEN = async ({ commit, state }) => {
    const api = axios.create(configureXhrApi(TOKEN_ENDPOINT));
    let variables = {
        ...(state.csrf && { [state.csrf.name]: state.csrf.value }),
    };
    // Execute the XHR
    await executeXhr(api, variables, (data) => {
        commit('SET_GQL_TOKEN', data);
    });
};

// Fetch the news entries
export const FETCH_NEWS = async ({ commit, state }) => {
    const token = state.gqlToken ? state.gqlToken.token : null;

    // Configure our API endpoint
    const api = axios.create(configureGqlApi(GRAPHQL_ENDPOINT, token));

    // Construct the variables object
    let variables = {}

    // Execute the GQL Query
    await executeGqlQuery(api, NEWS_QUERY, variables, (data) => {
        if (data.entries) {
            commit('SET_NEWS', data.entries);
        }
    })
}
