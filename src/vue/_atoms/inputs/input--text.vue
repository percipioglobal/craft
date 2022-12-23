<script setup lang="ts">
import { ref, onMounted } from 'vue'
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
    helper?: string,
    placeholder?: string,
    error?: boolean,
    errorMessage?: Array<string>,
    required?: boolean,
    value?: string,
    conditions?: any,
    visibility?: string,
}

const props = withDefaults(defineProps<Props>(), {
    label: '',
    icon: '',
    helper: '',
    placeholder: '',
    error: false,
    errorMessage: () => [],
    required: false,
    value: '',
    conditions: '',
    visibility: 'visible'
})

const emit = defineEmits(['set-field-value'])
const inputValue = ref('')

const updateValue = evt => {
    emit('set-field-value', evt.target.value)
}

onMounted(() => {
    inputValue.value = props.value
})
</script>
<template>
    <label
        v-if="useConditionalCheck(formValues, conditions)"
        :for="name"
        class="block mb-6"
    >
        <TextLabel
            v-if="label && visibility !== 'hidden'"
            :label="label"
            :required="required"
        />

        <div class="relative mt-2 mb-1 rounded-md">

            <div
                v-if="icon"
                class="absolute flex items-center justify-center w-12 h-full"
                :class=" errorMessage.length > 0 ? 'border-red-600' : 'border-gray-blue-200'"
            >
                <i :class="icon" />
            </div>

            <input
                :id="id"
                v-model="inputValue"
                :name="name"
                :required="required"
                :aria-invalid="error ? 'true' : 'false'"
                :class="[
                    icon ? 'pl-10 pr-4 sm:pr-6' : 'px-3 sm:px-4',
                    'rounded-md bg-grey-100 py-1 sm:py-2 appearance-none block w-full border placeholder-gray-400 focus:shadow-md focus:outline-none focus:ring-deep-orange-500 focus:ring-opacity-50 sm:text-sm',
                    errorMessage.length > 0 ? 'border-red-600' : 'border-gray-blue-200',
                    visibility === 'hidden' ? 'pointer-events-none h-1 w-1 absolute top-full right-0 p-0 opacity-0' : ''
                ]"
                type="text"
                @input="updateValue"
            >
        </div>

        <TextHelper
            v-if="helper && visibility !== 'hidden'"
            :helper="helper"
        />
        
        <div class="w-full">
            <TextError
                v-for="(message, index) in errorMessage"
                :key="'text-error_' + index"
                :error-message="message" 
            />   
        </div>

    </label>
</template>