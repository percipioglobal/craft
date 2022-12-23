<script setup lang="ts">
import Spinner from '@/vue/_atoms/svgs/svg--loader.vue'

interface Props {
    button: any,
    loading?: boolean
}

withDefaults(defineProps<Props>(), {
    loading: false
})

const emit = defineEmits(['touch'])

const onClick = () => {
    emit('touch')
}

</script>

<template>
    <button
        :aria-label="button.value"
        :data-tag-category="button?.gaCategory"
        :data-tag-action="button?.gaAction"
        :data-tag-label="button?.gaLabel"
        :class="
            [
                'font-bold flex items-center text-lg py-3 px-4 bg-black text-white hover:bg-gray-800 active:bg-gray-800',
                button.utilities
            ]
        "
        @click.prevent="onClick"
    >
        <span>
            {{ button.value }}
        </span>

        <span v-if="loading">
            <Spinner />
        </span>
    </button>
</template>