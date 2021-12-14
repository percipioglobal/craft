module.exports = {
    content: [
        '../src/templates/**/*.{twig,html}',
        '../src/vue/**/*.{vue,js}',
    ],
    safelist: [
        'aspect-h-1',
        'aspect-h-3',
        'aspect-h-4',
        'aspect-h-5',
        'aspect-h-9',
        'aspect-w-1',
        'aspect-w-16',
        'aspect-w-2',
        'aspect-w-21',
        'aspect-w-3',
        'aspect-w-4',
        'aspect-w-7',
        'aspect-w-8',
    ],
    theme: {
        extend: {},
    },
    plugins: [
        require('@tailwindcss/aspect-ratio'),
        require('@tailwindcss/line-clamp'),
        require('@tailwindcss/typography'),
    ],
};
