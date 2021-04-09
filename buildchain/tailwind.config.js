module.exports = {
    mode: 'jit',
    purge: {
        content: [
            '../src/templates/**/*.{twig,html}',
            '../src/vue/**/*.{vue,js}',
        ],
        layers: [
            'base',
            'components',
            'utilities',
        ],
        mode: 'layers',
        options: {
            whitelist: [
            ],
        }
    },
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

    },
    corePlugins: {},
    plugins: [
        require('@tailwindcss/typography'),
    ],
};