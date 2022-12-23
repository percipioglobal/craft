<script setup lang="ts">
import { useConditionalCheck } from '@/js/composables/useForm'

interface Props {
    headingSize: string,
    name: string,
    conditions?: any,
    formValues: any
}

withDefaults(defineProps<Props>(), {
    conditions: ''
})

const heading = (node: string, text: string): string => {
    return `<${node}>${text}<${node}>`
}
</script>
<template>
    <!-- eslint-disable vue/no-v-html -->
    <span
        v-if="useConditionalCheck(formValues, conditions)"
        class="block w-full font-primary text-base mb-6 text-gray-blue-700"
        v-html="heading(headingSize,name)"
    />
    <!-- eslint-enable -->
</template>