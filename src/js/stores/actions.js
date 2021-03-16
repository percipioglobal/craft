import axios from 'axios';
import { configureXhrApi, executeXhr } from '@/js/utils/xhr.js';
import { configureGqlApi, executeGqlQuery } from '@/js/utils/gql.js';
import { NEWS_QUERY } from '@/js/data/queries.js';


const CSRF_ENDPOINT = '/actions/site-module/csrf/get-csrf';
const TOKEN_ENDPOINT = '/actions/site-module/csrf/get-gql-token';
const GRAPHQL_ENDPOINT = '/api';

// Fetch & commit the CSRF token
export const fetchCsrf = async({commit}) => {
    const api = axios.create(configureXhrApi(CSRF_ENDPOINT));
    let variables = {
    };
    // Execute the XHR
    await executeXhr(api, variables, (data) => {
        commit('setCsrf', data);
    });
};

// Fetch & commit the GraphQL token
export const fetchGqlToken = async({commit, state}) => {
    const api = axios.create(configureXhrApi(TOKEN_ENDPOINT));
    let variables = {
        ...(state.csrf && { [state.csrf.name]: state.csrf.value }),
    };
    // Execute the XHR
    await executeXhr(api, variables, (data) => {
        commit('setGqlToken', data);
    });
};

// Fetch the news entries 
export const fetchNews = async({commit, state}) => {
    const token = state.gqlToken ? state.gqlToken.token : null;

    // Configure our API endpoint
    const api = axios.create(configureGqlApi(GRAPHQL_ENDPOINT, token));

    // Construct the variables object
    let variables = {}

    // Execute the GQL Query
    await executeGqlQuery(api, NEWS_QUERY, variables, (data) =>  {
        if (data.entries) {
            commit('setNews', data.entries);
        }
    })
}