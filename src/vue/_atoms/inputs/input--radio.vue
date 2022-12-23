<template>
    <label
        :class="[
            'relative mt-2 pl-1 text-gray-blue-900 flex items-center',
            standalone ? 'mb-6' : 'mb-1'
        ]"
    >

        <div class="flex items-center w-full">

            <div class="relative">
                <input
                    :name="name"
                    :required="required"
                    :aria-checked="checked"
                    :aria-invalid="error ? 'true' : 'false'"
                    :value="value"
                    :checked="checked"
                    type="radio"
                    tabindex="0"
                    class="absolute w-5 h-5 p-2 opacity-0"
                    @change="$emit('set-field-value', $event.target.value)"
                >

                <div class="flex items-center justify-center shrink-0 w-5 h-5 bg-white border-2 border-gray-blue-200 rounded-full focus-within:border-gray-blue-200">
                    <div
                        :class="[
                            'bg-deep-orange-500 w-1.5 h-1.5 rounded-full',
                            checked ? 'block' : 'hidden'
                        ]"
                    />
                </div>
            </div>

            <span class="inline-block ml-2 text-sm text-gray-900 font-primary">
                {{ label }}
            </span>

            <span class="inline-block ml-2 text-xs text-deep-orange-500 font-primary">
                {{ required ? '*' : '' }}
            </span>

        </div>

        <div class="w-full">
            <text--error 
                v-for="(message, index) in errorMessage" 
                :key="'radio-error' + index"
                :error-message="error" 
            />   
        </div>

    </label>
</template>

<script lang="ts">
import { defineAsyncComponent, defineComponent } from 'vue'

export default defineComponent({

    components: {
        'text--error': defineAsyncComponent(() => import(/* webpackChunkName: "text--error" */ '@/vue/_atoms/texts/text--error.vue')),
    },

    model: {
        prop: 'modelValue',
        event: 'change'
    },

    props: {

        label: {
            type: String,
            default: '',
        },

        name: {
            type: String,
            required: true
        },

        value: {
            type: String,
            required: true
        },

        checked: {
            type: Boolean,
            default: false
        },

        required: {
            type: Boolean,
            default: false
        },

        error: {
            type: Boolean,
            default: false
        },

        errorMessage: {
            type: Array,
            default: () => [],
        },

        standalone: {
            type: Boolean,
            default: true
        },

    },

    emits: ['set-field-value'],

})
</script>