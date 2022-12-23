import { gql } from '@apollo/client/core'

export const FORM = gql`
    query Form(
        $handle: [String]
    ){
        formieForm(handle: $handle) {
            title
            configJson
            rows {
                rowFields {
                    id
                    errorMessage
                    instructions
                    name
                    typeName
                    required
                    displayName
                    visibility
                    handle
                    enableConditions
                    conditions
                    ... on Field_Checkboxes {
                        id
                        name
                        typeName    
                        options {
                            label
                            value
                            isDefault
                        }
                    }
                    ... on Field_Agree {
                        id
                        name
                        typeName    
                        required
                        checkedValue
                        uncheckedValue
                    }
                    ... on Field_Dropdown {
                        id
                        name
                        typeName
                        defaultValue
                        options {
                            label
                            value
                            isDefault
                        }
                        placeholder
                    }
                    ... on Field_Radio {
                        id
                        name
                        typeName    
                        defaultValue
                        options {
                            value
                            label
                            isDefault
                        }
                    }
                    ... on Field_Hidden {
                        defaultValue
                        typeName    
                    }
                    ... on Field_Heading {
                        name
                        typeName    
                        headingSize
                    }
                    ... on Field_Number {
                        limit
                        max
                        min
                    }
                }
            }
        }
    }
`

export const SUBMIT = (form, params, vars) => {

    const mutation = `
        mutation SaveForm( ${params.join(', ')} ) {
            save_${form}_Submission(
                ${vars.join(', ')}
            )
            {
                title
            }
        }
    `

    return gql`${mutation}`
}