<script setup lang="ts">

interface Props {
    helper: string,
    utilities?: string
}

withDefaults(defineProps<Props>(), {
    utilities: ''
})

</script>
<template>
    <div
        :class="[
            'flex justify-between',
            utilities
        ]"
        aria-describedby="helper"
    >
        <span
            id="helper"
            class="block pl-1 mt-2 text-xs font-primary font-semibold text-grey-500"
        >
            {{ helper }}
        </span>
    </div>
</template>