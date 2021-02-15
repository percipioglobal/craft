// critical.settings.js

// node modules
require('dotenv').config();

// settings
module.exports = {
    critical: {
        base: '../cms/web/dist/criticalcss/',
        suffix: '_critical.min.css',
        criticalHeight: 1200,
        criticalWidth: 1200,
        ampPrefix: 'amp_',
        ampCriticalHeight: 19200,
        ampCriticalWidth: 600,
        pages: [
            {
                url: '',
                template: 'index'
            },
            {
                url: '',
                template: 'amp_index'
            },
            {
                url: 'errors/offline',
                template: 'errors/offline'
            },
            {
                url: 'errors/error',
                template: 'errors/error'
            },
            {
                url: 'errors/503',
                template: 'errors/503'
            },
            {
                url: 'errors/404',
                template: 'errors/404'
            },
        ]
    },
};
