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
                v-if="trailingIcon"
                class="absolute right-0 flex items-center justify-center w-12 h-full pr-1 border-l"
                :class=" errorMessage.length > 0 ? 'border-red-600' : 'border-gray-blue-200'"
            >
                <i :class="trailingIcon" />
            </div>

            <input
                :id="id"
                :name="name"
                :required="required"
                :aria-invalid="error ? 'true' : 'false'"
                type="email"
                autocomplete="email"
                :class="[
                    'rounded-md px-3 sm:pl-4 sm:pr-14 py-1 sm:py-2 appearance-none block w-full border placeholder-gray-400 bg-grey-100 focus:shadow-md focus:outline-none focus:ring-deep-orange-500 focus:ring-opacity-50 sm:text-sm',
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
                :key="'email-error_' + index"
                :error-message="message"
            />
        </div>

    </label>
</template>