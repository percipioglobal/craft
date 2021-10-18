// app.settings.js

// node modules
require('dotenv').config();
const path = require('path');

// settings
module.exports = {
    alias: {
        '@': path.resolve('../src'),
        vue: 'vue/dist/vue.esm-bundler.js',
    },
    copyright: '©2020 Percipio.London',
    entry: {
        'app': [
            '@/js/app.ts',
            '@/js/assets/icons.js',
            '@/css/app.pcss',
        ],
        'lazysizes-wrapper': '../src/js/utils/lazysizes-wrapper.ts',
    },
    extensions: ['.ts', '.js', '.vue', '.json'],
    name: 'percipio.london',
    paths: {
        dist: path.resolve('../cms/web/dist'),
    },
    urls: {
        criticalCss: 'https://percipio.london/',
        publicPath: () => process.env.PUBLIC_PATH || '/dist/',
    },
};
