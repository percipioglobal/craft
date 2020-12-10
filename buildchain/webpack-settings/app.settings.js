// app.settings.js

// node modules
require('dotenv').config();

// settings
module.exports = {
    alias: {
        'vue$': 'vue/dist/vue.esm.js'
    },
    copyright: '©2020 Percipio Global Ltd.',
    entry: {
        'app': [
            '../src/js/app.ts',
            '../src/css/app-base.pcss',
            '../src/css/app-components.pcss',
            '../src/css/app-utilities.pcss',
            '../src/js/assets/icons.js',
        ],
        'lazysizes-wrapper': '../src/js/utils/lazysizes-wrapper.ts',
    },
    extensions: ['.ts', '.js', '.vue', '.json'],
    name: 'percipio.london',
    paths: {
        dist: '../../cms/web/dist/',
    },
    urls: {
        criticalCss: 'https://sandbox.percipio.london/',
        publicPath: () => process.env.PUBLIC_PATH || '/dist/',
    },
};