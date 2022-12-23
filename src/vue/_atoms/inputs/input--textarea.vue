<script setup lang="ts">
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
    conditions?: any
}

withDefaults(defineProps<Props>(), {
    label: '',
    helper: '',
    placeholder: '',
    error: false,
    errorMessage: () => [],
    required: false,
    text: '',
    conditions: ''
})

const emit = defineEmits(['set-field-value'])

const updateValue = evt => {
    emit('set-field-value', evt.target.value)
}
</script>
<template>
    <label
        v-if="useConditionalCheck(formValues, conditions)"
        :for="name"
        class="block mb-6"
    >
        <TextLabel
            v-if="label"
            :label="label"
            :required="required"
        />

        <div 
            :class="[
                'rounded-md relative mt-2 mb-1 px-1 sm:px-1 py-1 sm:py-2 overflow-hidden bg-grey-100 border focus:shadow-md focus:outline-none focus:ring-deep-orange-500 focus:ring-opacity-50', 
                errorMessage.length > 0 ? 'border-red-600' : 'border-gray-blue-200'
            ]"
        >

            <textarea
                :id="id"
                :name="name"
                :required="required"
                :aria-invalid="error ? 'true' : 'false'"
                :class="[
                    'resize-none px-2 appearance-none w-full h-40 placeholder-gray-400 bg-grey-100 sm:text-sm border-0 focus:outline-none'
                ]"
                @input="updateValue"
            />
            
        </div>

        <TextHelper
            v-if="helper"
            :helper="helper"
        />
        
        <div class="w-full">
            <TextError
                v-for="(message, index) in errorMessage"
                :key="'textarea-error_' + index"
                :error-message="message" 
            />   
        </div>     

    </label>
</template>
