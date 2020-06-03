// Configure the XHR api endpoint
export const configureXhrApi = (url) => ({
    baseURL: url,
    headers: {
        'X-Requested-With': 'XMLHttpRequest'
    }
});

// Execute an XHR to our api endpoint
export const executeXhr = async(api, variables, callback) => {
    // Execute the XHR
    try {
        const response = await api.post('', variables);
        if (response.data) {
            callback(response.data);
        }
    } catch (error) {
        console.error(error);
    }
};