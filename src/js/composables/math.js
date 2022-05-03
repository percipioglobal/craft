export function escapeChars(str) {
    return str.replace(/([.?*+^$[\]\\(){}|-])/g, "\\$1");
}