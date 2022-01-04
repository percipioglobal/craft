import vue from '@vitejs/plugin-vue'
import legacy from '@vitejs/plugin-legacy'
import ViteRestart from 'vite-plugin-restart'
import { nodeResolve } from '@rollup/plugin-node-resolve'
import critical from 'rollup-plugin-critical'
import { ViteFaviconsPlugin } from "vite-plugin-favicon2"
import path from 'path'

// https://vitejs.dev/config/
export default ({ command }) => ({
    base: command === 'serve' ? '' : '/dist/',
    build: {
        emptyOutDir: true,
        manifest: true,
        outDir: '../cms/web/dist',
        rollupOptions: {
        input: {
            app: './src/js/app.ts',
            'lazysizes-wrapper': './src/js/utils/lazysizes-wrapper.ts',
        },
        output: {
            sourcemap: true
        },
        }
    },
    plugins: [
        critical({
            criticalUrl: 'https://percipio.london',
            criticalBase: '../cms/web/dist/criticalcss/',
            criticalPages: [
                { uri: '/', template: 'index' },
            ],
            criticalConfig: {
            }
        }),
        legacy({
            targets: ['defaults', 'not IE 11']
        }),
        nodeResolve({
            moduleDirectories: [
                path.resolve('./node_modules'),
            ],
        }),
        ViteFaviconsPlugin({
            logo: "./src/img/favicon-src.png",
            inject: false,
            outputPath: 'favicons',
        }),
        ViteRestart({
            reload: [
                './src/templates/**/*',
            ],
        }),
        vue(),
    ],
    publicDir: './src/public',
    resolve: {
        alias: {
            '@': path.resolve(__dirname, './src')
        },
        preserveSymlinks: true,
    },
    server: {
        fs: {
            strict: false
        },
        host: '0.0.0.0',
        origin: 'http://localhost:3000/',
        port: 3000,
        strictPort: true,
    }
});