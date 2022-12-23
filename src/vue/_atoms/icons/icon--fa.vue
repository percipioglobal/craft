<script setup lang="ts">
import { useIcons } from '@/js/composables/useIcons'

interface Props {
    icon: string,
    utilities?: string
}

withDefaults(defineProps<Props>(), {
    utilities: ''
})

</script>

<template>
    <i 
        aria-hidden="true" 
        :class="[useIcons(icon), utilities]" 
    />
</template>