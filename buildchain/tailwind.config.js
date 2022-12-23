module.exports = {
    content: [
        '../src/templates/**/*.{twig,html}',
        '../src/vue/**/*.{vue,js}',
    ],
    safelist: [ ],
    theme: {
        extend: {},
    },
    plugins: [
        require('@tailwindcss/aspect-ratio'),
        require('@tailwindcss/line-clamp'),
        require('@tailwindcss/typography'),
    ],
};
