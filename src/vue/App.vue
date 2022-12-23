<script lang="ts">
import { defineComponent } from 'vue'

import { init as initPageAnimation } from '@/js/animations/page'

import FormPrimary from '@/vue/_organisms/forms/form--primary.vue'
import IconFa from '@/vue/_atoms/icons/icon--fa.vue'

export default defineComponent({
    components: { 
        'form--primary': FormPrimary,
        'icon--fa': IconFa
    },
    mounted() {
        initPageAnimation()
    }
})
</script>