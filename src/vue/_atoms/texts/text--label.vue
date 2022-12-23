<script setup lang="ts">

interface Props {
    label: string,
    required?: boolean
}

withDefaults(defineProps<Props>(), {
    required: false
})

</script>
<template>
    <div class="relative flex items-center">
        <span class="pl-1 block font-primary text-sm font-semibold text-gray-blue-700">
            {{ label }}
        </span>

        <span class="block ml-2 text-xs text-deep-orange-500 font-primary">
            {{ required ? '*' : '' }}
        </span>
    </div>
</template>