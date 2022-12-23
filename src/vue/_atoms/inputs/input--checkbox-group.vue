<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useConditionalCheck } from '@/js/composables/useForm'

import TextError from '@/vue/_atoms/texts/text--error.vue'
import TextHelper from '@/vue/_atoms/texts/text--helper.vue'
import TextLabel from '@/vue/_atoms/texts/text--label.vue'
import InputCheckbox from '@/vue/_atoms/inputs/input--checkbox.vue'

interface Props {
    formValues: any,
    name: string,
    options: Array<any>,
    label?: string,
    helper?: string,
    error?: boolean,
    errorMessage?: Array<string>,
    required?: boolean,
    conditions?: any
    values?: any
}

const props = withDefaults(defineProps<Props>(), {
    label: '',
    error: false,
    errorMessage: () => [],
    required: false,
    conditions: '',
    helper: '',
    values: () => [],
})

const emit = defineEmits(['set-field-value'])
const checked = ref([])

const updateValue = value => {
    if(checked.value.includes(value)){
        checked.value.splice(checked.value.indexOf(value),1);
    } else {
        checked.value.push(value);
    }

    emit('set-field-value', checked.value)
}

onMounted(() => {
    checked.value = props.values
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

        <InputCheckbox
            v-for="checkbox in options" 
            :id="checkbox.value" 
            :key="checkbox.value"
            :name="name" 
            :label="checkbox?.label"
            :error="error" 
            :value="checkbox?.value"
            :required="required"
            :standalone="false"
            :form-values="null"
            :checked="checked.includes(checkbox?.value)"
            @set-field-value="updateValue"
        />

        <TextHelper
            v-if="helper"
            :helper="helper"
        />
                    
        <div class="w-full">
            <TextError
                v-for="(message, index) in errorMessage"
                :key="'group-error_' + index"
                :error-message="message" 
            />   
        </div>
    </div>
</template>