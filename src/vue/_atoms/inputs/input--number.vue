<script setup lang="ts">
import { ref } from 'vue'
import { useConditionalCheck } from '@/js/composables/useForm'

import TextError from '@/vue/_atoms/texts/text--error.vue'
import TextHelper from '@/vue/_atoms/texts/text--helper.vue'
import TextLabel from '@/vue/_atoms/texts/text--label.vue'

interface Props {
    id: string,
    formValues: any,
    name: string,
    label?: string,
    helper?: string,
    placeholder?: string,
    error?: boolean,
    errorMessage?: Array<string>,
    required?: boolean,
    text?: string,
    min?: number,
    max?: number,
    limit?: boolean,
    conditions?: any
}

const props = withDefaults(defineProps<Props>(), {
    label: '',
    helper: '',
    placeholder: '',
    error: false,
    errorMessage: () => [],
    required: false,
    text: '',
    conditions: '',
    min: null,
    max: null,
    limit: false,
})

const emit = defineEmits(['set-field-value'])
const validationErrors = ref([])

const updateValue = evt => {
    const number = parseFloat(evt.target.value)
    validationErrors.value = []

    if (props.limit ) {
        if ( props.min && number < props.min) {
            validationErrors.value.push('This value needs to be higher than ' + props.min)
        }

        if ( props.max && number > props.max) {
            validationErrors.value.push('This value needs to be lower or equal than ' + props.max)
        }
    }

    if (validationErrors.value.length > 0) {
        return
    }

    emit('set-field-value', number)
}
</script>
<template>
    <label
        v-if="useConditionalCheck(formValues, conditions)"
        class="block mb-6"
    >
        <TextLabel
            v-if="label"
            :label="label"
            :required="required"
        />

        <div class="relative mt-2 mb-1 rounded-md">
            <input
                :name="name"
                :required="required"
                :aria-invalid="error ? 'true' : 'false'"
                type="number"
                :class="[
                    'rounded-md px-3 sm:px-4 py-1 sm:py-2 appearance-none block w-full border placeholder-gray-400 bg-grey-100 focus:shadow-md focus:outline-none focus:ring-deep-orange-500 focus:ring-opacity-50 sm:text-sm text-gray-900',
                    errorMessage.length > 0 ? 'border-red-600' : 'border-gray-blue-200'
                ]"
                @input="updateValue"
            >
        </div>

        <TextHelper
            v-if="helper"
            :helper="helper"
        />

        <div class="w-full">
            <TextError
                v-for="(message, index) in validationErrors.concat(errorMessage)"
                :key="'number-error_' + index"
                :error-message="message" 
            /> 
        </div>

    </label>
</template>