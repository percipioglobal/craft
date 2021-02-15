// Configure the GraphQL api endpoint
export const configureGqlApi = (url, token) => ({
    baseURL: url,
    headers: {
        'X-Requested-With': 'XMLHttpRequest',
        ...(token && { 'Authorization': `Bearer ${token}` }),
    }
});

// Execute a GraphQL query by sending an XHR to our api endpoint
export const executeGqlQuery = async(api, query, variables, callback) => {
    // Execute the GQL query
    try {
        const response = await api.post('', {
            query: query,
            variables: variables
        });
        if (callback && response.data.data) {
            callback(response.data.data);
        }
        // Log any errors
        if (response.data.errors) {
            console.error(response.data.errors);
        }
    } catch (error) {
        console.error(error);
    }
};