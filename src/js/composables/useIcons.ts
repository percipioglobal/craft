interface Icons {
    [key: string]: string
}

export const LUT_ICONS: Icons = {
    'doc': 'far fa-file-word',
    'docx': 'far fa-file-word',
    'download': 'far fa-circle-down',
    'facebook': 'fab fa-facebook-f',
    'excel': 'far fa-file-excel',
    'envelope': 'far fa-envelope',
    'external-link': 'fas fa-arrow-up-right-from-square',
    'github': 'fab fa-github',
    'instagram': 'fab fa-instagram',
    'link': 'fas fa-link',
    'linkedin': 'fab fa-linkedin-in',
    'pdf': 'far fa-file-pdf',
    'ppt': 'far fa-file-excel',
    'pptx': 'far fa-file-excel',
    'print': 'fas fa-print',
    'wikipedia': 'fab fa-wikipedia-w',
    'word': 'far fa-file-word',
    'xls': 'far fa-file-excel',
    'xlsx': 'far fa-file-excel',
    'youtube': 'fab fa-youtube',
    'twitter': 'fab fa-twitter',
    'zip': 'far fa-file-zipper',
    '_default': 'fas fa-hashtag',
}

export const useIcons = (icon: string): string => {
    return LUT_ICONS[icon] ?? LUT_ICONS['_default']
}