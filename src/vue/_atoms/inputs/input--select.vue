<script setup lang="ts">
import { useConditionalCheck } from '@/js/composables/useForm'

import TextError from '@/vue/_atoms/texts/text--error.vue'
import TextHelper from '@/vue/_atoms/texts/text--helper.vue'
import TextLabel from '@/vue/_atoms/texts/text--label.vue'

interface Props {
    id: string,
    formValues: any,
    name: string,
    options: any,
    selected?: string,
    label?: string,
    helper?: string,
    error?: boolean,
    errorMessage?: Array<string>,
    required?: boolean,
    conditions?: any
}

withDefaults(defineProps<Props>(), {
    label: '',
    helper: '',
    error: false,
    errorMessage: () => [],
    required: false,
    conditions: '',
    selected: ''
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
                'relative mt-2 mb-1 text-gray-blue-900',
                'before:block before:absolute before:w-2 before:h-px before:-rotate-45 before:bg-black before:right-2 before:top-1/2',
                'after:block after:absolute after:w-2 after:h-px after:rotate-45 after:bg-black after:right-3 after:mr-px after:top-1/2'
            ]"
        >
            <select
                :class="[
                    'rounded-md w-full border bg-grey-100 p-2 pr-4 text-gray-900 text-sm focus:shadow-md focus:outline-none focus:ring-deep-orange-500 focus:ring-opacity-50 appearance-none',
                    errorMessage?.length > 0 ? 'border-red-600' : 'border-gray-blue-200'
                ]"
                :aria-invalid="error ? 'true' : 'false'"
                @change="updateValue"
            >
                <option
                    v-for="option in options"
                    :key="option.value"
                    :disabled="option.value === ''"
                    :selected="option?.value === selected"
                    :value="option.value"
                >{{ option.label }}</option>
            </select>

        </div>

        <TextHelper
            v-if="helper"
            :helper="helper"
        />

        <div class="w-full">
            <TextError
                v-for="(message, index) in errorMessage"
                :key="'select-error_' + index"
                :error-message="message"
            />
        </div>

    </label>
</template>