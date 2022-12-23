<script setup lang="ts">
import { computed, ref, onMounted } from 'vue'
import { storeToRefs } from 'pinia'
import { useFormStore } from '@/js/store/form'

import ButtonPrimary from '@/vue/_atoms/buttons/button--primary.vue'
import InputCheckboxGroup from '@/vue/_atoms/inputs/input--checkbox-group.vue'
import InputCheckbox from '@/vue/_atoms/inputs/input--checkbox.vue'
import InputEmail from '@/vue/_atoms/inputs/input--email.vue'
import InputHeading from '@/vue/_atoms/inputs/input--heading.vue'
import InputNumber from '@/vue/_atoms/inputs/input--number.vue'
import InputPhone from '@/vue/_atoms/inputs/input--phone.vue'
import InputRadioGroup from '@/vue/_atoms/inputs/input--radio-group.vue'
import InputSelect from '@/vue/_atoms/inputs/input--select.vue'
import InputText from '@/vue/_atoms/inputs/input--text.vue'
import InputTextarea from '@/vue/_atoms/inputs/input--textarea.vue'
import Spinner from '@/vue/_atoms/svgs/svg--loader.vue'

// PROPS
interface Props {
    handle: string,
    hidden?: any
    showSuccess?: boolean
}
const props = withDefaults(defineProps<Props>(), {
    hidden: {},
    showSuccess: true
})

// STORE
const formStore = useFormStore()
const { success, errors, form, config, fields } = storeToRefs(formStore)

// VARIABLES
const values = ref({})
const loading = ref(true)
const submitting = ref(false)


// COMPUTED
const submitButton = computed(() => {
    return {
        gaLabel: `Submit ${ form.value?.title }`,
        gaCategory: 'Forms',
        gaAction: 'Submit',
        value: submitLabel.value,
        utilities: submitting.value ? 'opacity-50 pointer-events-none' : ''
    }
})

const submitLabel = computed(() => {
    const label = config.value?.settings?.pages[0]?.settings?.submitButtonLabel
    return label ?? 'Submit'
})

const successMessage = computed(() => {
    const message = config.value?.settings?.submitActionMessage
    return message ?? 'Success'
})


// METHODS
const setFieldValue = (value, handle) => {
    values.value[handle] = value
}

const setFieldValues = (value, handle) => {
    values.value[handle] = [value]
}

const toggleFieldValue = (value, handle) => {
    if(values.value[handle] === value){
        values.value[handle] = ""
    } else {
        values.value[handle] = value
    }
}

const setFormValueStructure = () => {

    fields.value.forEach(input => {
        // make an array out of a checkboxes input
        if (input.displayName === 'Checkboxes') {
            values.value[input.handle] = []
        }

        // set null as default value for numbers
        else if (input.displayName === 'Number') {
            values.value[input.handle] = null
        }

        // all other fields should have an empty string value
        else {
            values.value[input.handle] = ''
        }
    })
    
}

const setFormDefaultValues = () => {
    fields.value.forEach(input => {
        if (props.hidden && (props.hidden[input.handle] ?? null)) {
            const value = props.hidden[input.handle] ?? input.defaultValue ?? ''
            setFieldValue(value, input.handle)
        }

        if (input.displayName === 'Dropdown') {
            const selected = input.options.find(option => option.isDefault)
            if (selected?.value) {
                setFieldValue(selected?.value, input.handle)
            } 
        }

        if (input.displayName === 'Checkboxes') {
            const selected = input.options.find(option => option.isDefault)
            if (selected?.value) {
                setFieldValues(selected?.value, input.handle)
            }
        }

        if (input.displayName === 'Radio') {
            const selected = input.options.find(option => option.isDefault)
            if (selected?.value) {
                setFieldValue(selected?.value, input.handle)
            }
        }
    })
}

const errorMessage = handle => {
    let error = []

    if(errors.value){

        error = errors.value[handle] ?? []
    }

    return error
}

const parseConditions = conditions => {
    const jsonConditions = JSON.parse(conditions)

    // save the display name to which field the condition checks upon
    jsonConditions.conditions.forEach(condition => {
        const handle = condition.field.replace(/[^a-z0-9]/gi, '')
        const field = fields.value.find(field => field.handle === handle)

        if (field) {
            condition.displayName = field.displayName
        }
    })

    return jsonConditions
}

const onSubmit = async() => {
    submitting.value = true

    await formStore.submit({
        values: values.value
    })

    submitting.value = false
}

// LIFECYLES
onMounted(async () => {
    await formStore.fetch('percipio')
    setFormValueStructure()
    setFormDefaultValues()

    loading.value = false
})
</script>

<template>
    <form novalidate>
        <div v-if="loading">
            <Spinner />
        </div>

        <div
            v-if="success && showSuccess"
            role="alert"
            class="w-full p-3 mb-5 text-green-700 shadow-lg bg-green-50"
        >
            <span
                class="inline-block py-1 font-bold border-green-100 font-primary"
                role="status"
            >
                {{ successMessage }}
            </span>
        </div>

        <div v-if="!success">
            <div
                v-for="(input, i) in fields"
                :key="`primary-form-field-${i}`"
            >
                <InputNumber
                    v-if="input.displayName === 'Number'"
                    :id="`${input.id}_${input.handle}`"
                    :label="input.name"
                    :helper="input.instructions"
                    :name="input.handle"
                    :required="input.required"
                    :error="errorMessage(input.handle).length > 0"
                    :error-message="errorMessage(input.handle)"
                    :min="input.min"
                    :max="input.max"
                    :limit="input.limit"
                    :conditions="input.enableConditions ? parseConditions(input.conditions) : ''"
                    :form-values="values"
                    @set-field-value="(value) => setFieldValue(value,input.handle)"
                />

                <InputEmail
                    v-if="input.displayName === 'Email'"
                    :id="`${input.id}_${input.handle}`"
                    :label="input.name"
                    :helper="input.instructions"
                    :name="input.handle"
                    :required="input.required"
                    :error="errorMessage(input.handle).length > 0"
                    :error-message="errorMessage(input.handle)"
                    :conditions="input.enableConditions ? parseConditions(input.conditions) : ''"
                    :form-values="values"
                    @set-field-value="(value) => setFieldValue(value,input.handle)"
                />

                <InputPhone
                    v-if="input.displayName === 'Phone'"
                    :id="`${input.id}_${input.handle}`"
                    :label="input.name"
                    :helper="input.instructions"
                    :name="input.handle"
                    :required="input.required"
                    :error="errorMessage(input.handle).length > 0"
                    :error-message="errorMessage(input.handle)"
                    :conditions="input.enableConditions ? parseConditions(input.conditions) : ''"
                    :form-values="values"
                    @set-field-value="(value) => setFieldValue(value,input.handle)"
                />

                <InputSelect
                    v-if="input.displayName === 'Dropdown'"
                    :id="`${input.id}_${input.handle}`"
                    :label="input.name"
                    :helper="input.instructions"
                    :name="input.handle"
                    :required="input.required"
                    :error="errorMessage(input.handle).length > 0"
                    :error-message="errorMessage(input.handle)"
                    :options="input.options"
                    :conditions="input.enableConditions ? parseConditions(input.conditions) : ''"
                    :form-values="values"
                    @set-field-value="(value) => setFieldValue(value,input.handle)"
                />

                <InputTextarea
                    v-if="input.displayName === 'MultiLineText'"
                    :id="`${input.id}_${input.handle}`"
                    :label="input.name"
                    :helper="input.instructions"
                    :name="input.handle"
                    :required="input.required"
                    :error="errorMessage(input.handle).length > 0"
                    :error-message="errorMessage(input.handle)"
                    :conditions="input.enableConditions ? parseConditions(input.conditions) : ''"
                    :form-values="values"
                    @set-field-value="(value) => setFieldValue(value,input.handle)"
                />

                <InputRadioGroup
                    v-if="input.displayName === 'Radio'"
                    :id="`${input.id}_${input.handle}`"
                    :label="input.name"
                    :helper="input.instructions"
                    :name="input.handle"
                    :required="input.required"
                    :error="errorMessage(input.handle).length > 0"
                    :error-message="errorMessage(input.handle)"
                    :options="input.options"
                    :conditions="input.enableConditions ? parseConditions(input.conditions) : ''"
                    :form-values="values"
                    :value="values[input.handle] ?? ''"
                    @set-field-value="(value) => setFieldValue(value,input.handle)"
                />

                <InputCheckboxGroup
                    v-if="input.displayName === 'Checkboxes'"
                    :id="`${input.id}_${input.handle}`"
                    :label="input.name"
                    :helper="input.instructions"
                    :name="input.handle"
                    :required="input.required"
                    :error="errorMessage(input.handle).length > 0"
                    :error-message="errorMessage(input.handle)"
                    :options="input.options"
                    :conditions="input.enableConditions ? parseConditions(input.conditions) : ''"
                    :form-values="values"
                    :values="values[input.handle] ?? []"
                    @set-field-value="(value) => setFieldValue(value,input.handle)"
                />

                <InputCheckbox
                    v-if="input.displayName === 'Agree'"
                    :id="`${input.id}_${input.handle}`"
                    :label="input.name"
                    :helper="input.instructions"
                    :name="input.handle"
                    :required="input.required"
                    :error="errorMessage(input.handle).length > 0"
                    :error-message="errorMessage(input.handle)"
                    :value="input.checkedValue"
                    :checked="values[input.handle] === input.checkedValue"
                    :conditions="input.enableConditions ? parseConditions(input.conditions) : ''"
                    :form-values="values"
                    @set-field-value="(value) => toggleFieldValue(value,input.handle)"
                />

                <InputText
                    v-if="input.displayName === 'SingleLineText'"
                    :id="`${input.id}_${input.handle}`"
                    :label="input.name"
                    :helper="input.instructions"
                    :name="input.handle"
                    :required="input.required"
                    :error="errorMessage(input.handle).length > 0"
                    :error-message="errorMessage(input.handle)"
                    :value="values[input.handle] ?? ''"
                    :visibility="input.visibility"
                    :conditions="input.enableConditions ? parseConditions(input.conditions) : ''"
                    :form-values="values"
                    @set-field-value="(value) => setFieldValue(value,input.handle)"
                />

                <InputHeading
                    v-if="input.displayName === 'Heading'"
                    :heading-size="input.headingSize"
                    :name="input.name"
                    :conditions="input.enableConditions ? parseConditions(input.conditions) : ''"
                    :form-values="values"
                />
            </div>

            <ButtonPrimary
                v-if="!success && form"
                :button="submitButton"
                :loading="submitting"
                @touch="onSubmit"
            />
        </div>
    </form>
</template>