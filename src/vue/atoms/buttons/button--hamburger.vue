<template>
    <button @click.prevent="toggleMenu" class="ml-auto" aria-label="navigation-toggle">

        <span class="">
            <span 
                :class="[
                    'bg-' + color,
                    'mb-2 block w-12 h-2',
                    'transform transition ease-in-out duration-200',
                    getNavigationActive ? 'rotate-45 translate-y-2' : ''
                ]">
            </span>
            <span 
                :class="[
                    'bg-' + color,
                    'block w-12 h-2',
                    'transform transition ease-in-out duration-200',
                    getNavigationActive ? '-rotate-45 -translate-y-2' : ''
                ]">
            </span>
        </span>

    </button>
</template>

<script>

    import { mapGetters } from 'vuex';

    export default {

        props: {
            color: {
                type: String,
                required: true,
            }
        },

        computed: {
            ...mapGetters(['getNavigationActive']),
        },
        
        methods: {
            toggleMenu() {
                this.$store.commit('setNavigationActive', !this.getNavigationActive);
                document.body.classList.toggle("overflow-hidden");
            }
        }

    }

</script>