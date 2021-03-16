module.exports = {
    theme: {

        container: {
            padding: {
                DEFAULT: '1rem',
                sm: '2rem',
                '2xl': '0',
            },
        },

        // Extend the default Tailwind config here
        extend: {
        },
        // Replace the default Tailwind config here
    },
    corePlugins: {},
    plugins: [
        require('@tailwindcss/typography'),
    ],
};