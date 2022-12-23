export const useConditionalCheck = (formValues: any, conditions: any) => {
    if (!conditions) {
        return true
    }

    if (conditions.conditions.length === 0) {
        return true
    }

    const conditionsReturned: any = []

    conditions.conditions.forEach((condition: any) => {
        const field = condition.field.replace(/[^a-z0-9]/gi, '')
        const formFieldValue = formValues[field] ?? null

        switch (condition.condition) {
        case '>' :
            conditionsReturned.push((formFieldValue ?? 0) > condition.value) 
            break
        case '<' :
            conditionsReturned.push((formFieldValue ?? 0) < condition.value) 
            break
        case '=' :
            conditionsReturned.push(fieldEqualCheck(formFieldValue ?? '', condition.value, condition.displayName)) 
            break
        case '!=' :
            conditionsReturned.push(fieldNotEqualCheck(formFieldValue ?? '', condition.value, condition.displayName)) 
            break
        case 'contains' :
            conditionsReturned.push((formFieldValue ?? '').includes(condition.value)) 
            break
        case 'startsWith': 
            conditionsReturned.push((formFieldValue ?? '').startsWith(condition.value)) 
            break
        case 'endsWith':
            conditionsReturned.push((formFieldValue ?? '').endsWith(condition.value)) 
            break
        }
    })

    let returnedValue = true

    if (conditions.conditionRule === 'all') {
        returnedValue = conditionsReturned.filter((val: boolean) => val === true).length === conditionsReturned.length
    } else {
        returnedValue = conditionsReturned.filter((val: boolean) => val === true).length > 0
    }

    return conditions.showRule === 'show' ? returnedValue : !returnedValue
}

const fieldEqualCheck = (formFieldValue: any, conditionValue: string, displayName: string) => {
    let value: string|number = conditionValue
    if (displayName === 'Agree') {
        value = conditionValue.length > 0 ? 1 : 0
    }

    return formFieldValue == value
}

const fieldNotEqualCheck = (formFieldValue: any, conditionValue: string, displayName: string) => {
    let value: string|number = conditionValue
    if (displayName === 'Agree') {
        value = conditionValue.length > 0 ? 1 : 0
    }

    return formFieldValue != value
}