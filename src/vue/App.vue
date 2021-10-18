<script>

    import { defineAsyncComponent, defineComponent } from 'vue'
    import { mapGetters } from 'vuex'

    export default defineComponent({

        components: {
            'notification--cookie': defineAsyncComponent(() => import(/* webpackChunkName: "notification--cookie" */ '@/vue/molecules/notifications/notification--cookie.vue')),
        },

        data: () => ({}),

        computed: {
            ...mapGetters([
                'tokens/GQL_TOKEN'
            ])
        },

        methods: {

            printPage() {
                window.print();
            }

        },

        async mounted(){

            if(!this.GQL_TOKEN) {
                await this.$store.dispatch('tokens/FETCH_CSRF')
                await this.$store.dispatch('tokens/FETCH_GQL_TOKEN')
            }

        }
    })

</script>
