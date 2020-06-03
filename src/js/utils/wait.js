// Main Store
export const createLoadingState = async(Vue) => {
    const { default: VueWait } = await import(/* webpackChunkName: "vue-wait" */ 'vue-wait');
    Vue.use(VueWait);
    return new VueWait({
        useVuex: true,                  // Uses Vuex to manage wait state
        vuexModuleName: 'wait',         // Vuex module name

        registerComponent: true,        // Registers `v-wait` component
        componentName: 'loading',       // <v-wait> component name, you can set `my-loader` etc.

        registerDirective: true,        // Registers `v-wait` directive
        directiveName: 'loading',       // <span v-wait /> directive name, you can set `my-loader` etc.
    })
}