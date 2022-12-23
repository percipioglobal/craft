import { ApolloClient, from, InMemoryCache, HttpLink } from '@apollo/client/core'
import { setContext } from '@apollo/client/link/context'
import { getToken } from './useAxiosClient'
import { ENDPOINT } from '../utils/environment'

// HTTP connection to the API
const httpLink = new HttpLink({
    uri: `${ENDPOINT()}api`,
    credentials: 'include'
})

const authLink = setContext(async (_, { headers }) => {
    // get the authentication token from the store, if it's null fetch it through axios
    const token = await getToken()

    return {
        headers: {
            ...headers,
            authorization: `Bearer ${token}`
        }
    }
})

export const defaultClient = new ApolloClient({
    cache: new InMemoryCache(),
    link: from([authLink, httpLink])
})
