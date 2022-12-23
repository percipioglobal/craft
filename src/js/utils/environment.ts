const domain = import.meta.env.VITE_SITE_URL
const environemnt = import.meta.env.VITE_ENVIRONMENT

export const ENV = (): string => environemnt

export const ENDPOINT = (): string => (domain ?? '') + '/'
