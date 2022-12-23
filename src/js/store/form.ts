import { defineStore } from 'pinia'
import { defaultClient } from '../composables/useApolloClient'

import { FORM, SUBMIT } from '../data/formQueries'

interface FormState {
    fields: Array<any>,
    form: any|null,
    config: any|null,
    errors: any|null,
    success: boolean
}

export const useFormStore = defineStore('form', {
    state: (): FormState => ({
        fields: [],
        form: null,
        config: null,
        errors: null,
        success: false
    }),
    actions: {
        async fetch(handle: string) {
            this.fields = []

            const { data } = await defaultClient.query({
                query: FORM,
                variables: {
                    handle: handle
                },
            })

            if (data.formieForm ?? null) {
                this.form = data.formieForm
                this.config = JSON.parse(this.form?.configJson ?? '')

                this.form?.rows.forEach((row: any) => {
                    this.fields.push(...row.rowFields)
                })
            }
        },
        async submit(values: any) {
            const params = this.fields.map(field => {
                if (field.typeName === 'Field_School') {
                    return '$' + field.handle + ': ' + this.form?.handle + '_' + field.handle + '_FormieSchoolInput'
                }

                if (field.typeName === 'Field_Checkboxes') {
                    return '$' + field.handle + ': [String]'
                }

                if (field.typeName === 'Field_Number') {
                    return '$' + field.handle + ': Number'
                }

                return '$' + field.handle + ': String'
            })

            const vars = this.fields.map(field => {
                return field.handle + ': $' + field.handle
            })

            this.errors = null
            this.success = false

            try {
                const { data } = await defaultClient.mutate({
                    mutation: SUBMIT(this.config.formHandle, params, vars),
                    variables: { ...values }.values
                })

                if (data) {
                    this.success = true
                }

            } catch(error) {
                if (error.graphQLErrors[0].message ?? null) {
                    this.errors = JSON.parse(error.graphQLErrors[0].message)
                }
            }

            console.log("submit", this.errors)
        }
    }
})