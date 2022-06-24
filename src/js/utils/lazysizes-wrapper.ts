// Load the lazysizes JS for legacy browsers
// this small shim is used to allow transpilation of the loading code
const main = async() => {
    const LazySizes = await import(/* webpackChunkName: "lazysizes" */ 'lazysizes');
    LazySizes.init();
};
// Execute async function
main().then(() => {
    console.log()
});