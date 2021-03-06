// copy.settings.js

// node modules
require('dotenv').config();

// settings
module.exports = {
    copy: [
        {
            from: '@/js/example-file.js',
            to: 'js/[name].[ext]',
            noErrorOnMissing: true,
        }
    ],
};
