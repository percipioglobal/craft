<script setup lang="ts">

interface Props {
    errorMessage: string,
    checkbox?: boolean
}

withDefaults(defineProps<Props>(), {
    checkbox: false
})

</script>

<template>
    <div 
        :class="[ checkbox ? '' : 'flex justify-between']"
    >
        <span 
            id="errorMessage" 
            :class="[ checkbox ? '' : 'block pl-1', 'pt-2 text-xs font-semibold text-red-600'
            ]"
        >
            {{ errorMessage }}
        </span>
    </div>
</template>