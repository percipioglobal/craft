<script setup lang="ts">
import { useConditionalCheck } from '@/js/composables/useForm'

import TextError from '@/vue/_atoms/texts/text--error.vue'

interface Props {
    id: string,
    value: string,
    formValues: any,
    name: string,
    label?: string,
    error?: boolean,
    errorMessage?: Array<string>,
    required?: boolean,
    conditions?: any,
    standalone?: boolean,
    checked?: boolean
}

withDefaults(defineProps<Props>(), {
    label: '',
    error: false,
    errorMessage: () => [],
    required: false,
    conditions: '',
    standalone: true,
    checked: false
})

const emit = defineEmits(['set-field-value'])

const updateValue = evt => {
    emit('set-field-value', evt.target.value)
}
</script>
<template>
    <label
        v-if="useConditionalCheck(formValues, conditions)"
        :class="[
            'relative mt-2 pl-1 text-gray-blue-900 block',
            standalone ? 'mb-6' : 'mb-1'
        ]"
    >
        <div class="flex items-center w-full">

            <div class="relative">
                <input
                    :name="name"
                    :required="required"
                    :aria-checked="checked ? 'true' : 'false'"
                    :aria-invalid="error ? 'true' : 'false'"
                    :value="value"
                    :checked="checked"
                    type="checkbox"
                    tabindex="0"
                    class="absolute w-5 h-5 p-2 opacity-0"
                    @change="updateValue"
                >

                <div class="flex items-center justify-center shrink-0 w-5 h-5 bg-white border-2 border-gray-blue-200 rounded-md focus-within:border-gray-blue-200">
                    <svg 
                        :class="[
                            'fill-current w-3 h-3 text-grey-600 pointer-events-none',
                            checked ? 'block' : 'hidden'
                        ]" 
                        version="1.1" 
                        viewBox="0 0 17 12" 
                        xmlns="http://www.w3.org/2000/svg"
                    >
                        <g
                            fill="none"
                            fill-rule="evenodd"
                        >
                            <g
                                transform="translate(-9 -11)"
                                fill="#fa5622"
                                fill-rule="nonzero"
                            >
                                <path d="m25.576 11.414c0.56558 0.55188 0.56558 1.4439 0 1.9961l-9.404 9.176c-0.28213 0.27529-0.65247 0.41385-1.0228 0.41385-0.37034 0-0.74068-0.13855-1.0228-0.41385l-4.7019-4.588c-0.56584-0.55188-0.56584-1.4442 0-1.9961 0.56558-0.55214 1.4798-0.55214 2.0456 0l3.679 3.5899 8.3812-8.1779c0.56558-0.55214 1.4798-0.55214 2.0456 0z" />
                            </g>
                        </g>
                    </svg>
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
            <TextError
                v-for="(message, index) in errorMessage"
                :key="'checkbox-error_' + index"
                :error-message="message" 
            />   
        </div>

    </label>
</template>