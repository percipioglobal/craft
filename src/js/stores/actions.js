import axios from 'axios';
import { configureXhrApi, executeXhr } from '../utils/xhr.js';
import { configureGqlApi, executeGqlQuery } from '../utils/gql.js';

const CSRF_ENDPOINT = '/actions/site-module/csrf/get-csrf';
const TOKEN_ENDPOINT = '/actions/site-module/csrf/get-gql-token';
const GRAPHQL_ENDPOINT = '/api';

// Fetch & commit the CSRF token
export const getCsrf = async({commit, state}) => {
    const api = axios.create(configureXhrApi(CSRF_ENDPOINT));
    let variables = {
    };
    // Execute the XHR
    await executeXhr(api, variables, (data) => {
        commit('setCsrf', data);
    });
};

// Fetch & commit the GraphQL token
export const getGqlToken = async({commit, state}) => {
    const api = axios.create(configureXhrApi(TOKEN_ENDPOINT));
    let variables = {
        ...(state.csrf && { [state.csrf.name]: state.csrf.value }),
    };
    // Execute the XHR
    await executeXhr(api, variables, (data) => {
        commit('setGqlToken', data);
    });
};

// Vue - Craft CMS field mapping;
const additionalParamFields = {
    
};

// Push additional params
const pushAdditionalParam = (state, dataFieldName, dbFieldName, additionalParams) => {
    let fieldValue = state.searchForm ? state.searchForm[dataFieldName] || '' : '';
    if (fieldValue.length) {
        additionalParams.push({
            fieldName: dbFieldName,
            fieldValue: fieldValue,
        });
    }
};