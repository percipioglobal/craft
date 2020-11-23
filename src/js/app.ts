// Import our CSS
import '../css/tailwind-base.pcss';
import '../css/app-base.pcss';
import '../css/tailwind-components.pcss';
import '../css/app-components.pcss';
import '../css/tailwind-utilities.pcss';
import '../css/app-utilities.pcss';

import { createStore } from './stores/store.js';
import { createLoadingState } from './utils/wait.js';

// importing and setting up Font Awesome
import { dom, library } from '@fortawesome/fontawesome-svg-core';
import {
    faFilePdf as farFilePdf,
    faFileExcel as farFileExcel,
    faFileWord as farFileWord,
    faFilePowerpoint as farFilePowerPoint,
    faFileArchive as farFileArchive,
} from '@fortawesome/free-regular-svg-icons';

import {
    faCloudDownloadAlt as fasCloudDownloadAlt,
    faExternalLinkAlt as fasExternalLinkAlt,
} from '@fortawesome/free-solid-svg-icons';

// load font-awesome libraries
library.add(farFilePdf, farFileExcel, farFileWord, farFilePowerPoint, farFileArchive, fasCloudDownloadAlt, fasExternalLinkAlt);

// convert i tags to SVG
dom.watch({
    autoReplaceSvgRoot: document,
    observeMutationsRoot: document.body
});

// App main
const main = async () => {
    // Async load the vue module
    const [ Vue, Lazysizes ] = await Promise.all([
        import(/* webpackChunkName: "vue" */ 'vue'),
        import(/* webpackChunkName: "lazysizes" */ 'lazysizes'),
    ])

    const store = await createStore(Vue.default);
    const wait = await createLoadingState(Vue.default);

    // Create our vue instance
    const app = new Vue.default({
        el: "#page-container",
        store,
        wait,
        data: () => ({

        }),
        components: {

        },
        methods: {

        }
    });

    // Mount the app
    const root = app.mount("#page-container");

    return root;
};

// Execute async function
main().then( (root) => {
});

// Accept HMR as per: https://webpack.js.org/api/hot-module-replacement#accept
if (module.hot) {
    module.hot.accept();
}