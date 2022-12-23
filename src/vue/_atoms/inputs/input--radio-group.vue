<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useConditionalCheck } from '@/js/composables/useForm'

import TextError from '@/vue/_atoms/texts/text--error.vue'
import TextHelper from '@/vue/_atoms/texts/text--helper.vue'
import TextLabel from '@/vue/_atoms/texts/text--label.vue'
import InputRadio from '@/vue/_atoms/inputs/input--radio.vue'

interface Props {
    id: string,
    formValues: any,
    name: string,
    options: any,
    label?: string,
    helper?: string,
    placeholder?: string,
    error?: boolean,
    errorMessage?: Array<string>,
    required?: boolean,
    value?: string,
    conditions?: any,
}

const props = withDefaults(defineProps<Props>(), {
    label: '',
    helper: '',
    placeholder: '',
    error: false,
    errorMessage: () => [],
    required: false,
    value: '',
    conditions: ''
})

const emit = defineEmits(['set-field-value'])
const checked = ref('')

const updateValue = value => {
    checked.value = value;
    emit('set-field-value', checked.value)
}

onMounted(() => {
    checked.value = props.value
})
</script>
<template>
    <div 
        v-if="useConditionalCheck(formValues, conditions)"
        class="block mb-6"
    >
        <TextLabel
            v-if="label"
            :label="label"
            :required="required"
        />

        <InputRadio
            v-for="radio in options" 
            :key="radio?.value" 
            :name="name"
            :label="radio?.label"
            :error="error" 
            :value="radio?.value"
            :required="required"
            :standalone="false"
            :checked="checked === radio?.value"
            @set-field-value="updateValue"
        />

        <TextHelper
            v-if="helper"
            :helper="helper"
        />

        <div class="w-full">
            <TextError
                v-for="(message, index) in errorMessage"
                :key="'radio-group-error_' + index"
                :error-message="message" 
            />   
        </div>
    </div>
</template>