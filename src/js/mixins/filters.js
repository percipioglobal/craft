import { escapeChars } from '@/js/functions/math';

export const replace = {
    filters: {
        replace(val, str1, str2) {
            let re = new RegExp(escapeChars(str1), 'g');
            return val.replace(re, str2);
        },
    }
}