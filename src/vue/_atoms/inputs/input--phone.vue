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
    icon?: string,
    trailingIcon?: string,
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
    icon: '',
    trailingIcon: '',
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

        <div class="relative mt-2 mb-1 rounded-md">

            <div
                v-if="icon"
                class="absolute left-0 flex items-center justify-center w-20 h-full pl-2 pr-4 border-r"
                :class=" errorMessage.length > 0 ? 'border-red-600' : 'border-gray-blue-200'"
            >
                <span class="pl-2 pr-2">UK</span>
            </div>

            <input
                :id="id"
                :name="name"
                :required="required"
                :aria-invalid="error ? 'true' : 'false'"
                type="tel"
                autocomplete="phone"
                pattern="^\s*\(?(020[7,8]{1}\)?[ ]?[1-9]{1}[0-9{2}[ ]?[0-9]{4})|(0[1-8]{1}[0-9]{3}\)?[ ]?[1-9]{1}[0-9]{2}[ ]?[0-9]{3})\s*$"
                :class="[
                    icon ? 'pl-24 pr-4 sm:pr-6' : 'px-3 sm:px-4',
                    'rounded-md py-1 sm:py-2 appearance-none block w-full border placeholder-gray-400 bg-grey-100 focus:shadow-md focus:outline-none focus:ring-deep-orange-500 focus:ring-opacity-50 sm:text-sm',
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
                v-for="(message, index) in errorMessage"
                :key="'phone-error_' + index"
                :error-message="message" 
            />   
        </div>

    </label>
</template>