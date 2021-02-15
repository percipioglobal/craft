export const NEWS_QUERY = `
    query {
        entries(section: "news") {
            id,
            title,
            slug,
        }
    }
`