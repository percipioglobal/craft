module.exports = {
    plugins: [
        require('postcss-import')({
            plugins: [],
            path: ['./node_modules'],
        }),
        require('postcss-font-awesome'),
        require('tailwindcss')('./tailwind.config.js'),
        require('postcss-preset-env')({
            autoprefixer: { },
            features: {
                'nesting-rules': true
            }
        })
    ]
};