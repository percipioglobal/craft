<script>

    import { defineAsyncComponent, defineComponent } from 'vue'
    import { mapGetters } from 'vuex'

    export default defineComponent({

        components: {
            'notification--cookie': () => import(/* webpackChunkName: "notification--cookie" */ '@/vue/molecules/notifications/notification--cookie.vue'),
        },

        data: () => ({}),

        computed: {
            ...mapGetters([
                'GQL_TOKEN'
            ])
        },

        methods: {

            printPage() {
                window.print();
            }

        },

        async mounted(){

            if(!this.GQL_TOKEN) {
                await this.$store.dispatch('FETCH_CSRF')
                await this.$store.dispatch('FETCH_GQL_TOKEN')
            }

            // await this.$store.dispatch("FETCH_PLACEHOLDERS")
        }
    })

</script>
