import axios from 'axios'
import { ENDPOINT } from '../utils/environment'

export const getToken = async (): Promise<string | null> => {

    const token = {
        value: null,
    }

    await axios({
        method: 'get',
        url: `${ENDPOINT()}actions/site-module/csrf/get-gql-token`,
    })
        .then((response) => {
            token.value = response?.data?.token ? response.data.token : null
        })

    return token.value || null
}