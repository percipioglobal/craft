<?php 

return [
    'fields' => [
        'contentBuilder' => [
            'hideUngroupedTypes' => true,
            'groups' => [
                [
                    'label' => 'Article',
                    'types' => ['sectionHeader', 'article', 'blockQuote']
                ],
                [
                    'label' => 'Cards',
                    'types' => ['highlightCards', 'spotlightCards']
                ],
                [
                    'label' => 'Media',
                    'types' => ['singleImage', 'galleryImages', 'media', 'form']
                ],
                [
                    'label' => 'Stacked Lists',
                    'types' => ['resourceList']
                ]
            ]
        ],
        'pageBuilder' => [
            'hideUngroupedTypes' => true,
            'groups' => [
                [
                    'label' => 'Article',
                    'types' => ['sectionHeader']
                ],
                [
                    'label' => 'Cards',
                    'types' => ['highlightCards', 'spotlightCards']
                ],
                [
                    'label' => 'Media',
                    'types' => ['galleryImages']
                ],
            ]
        ],
    ]
];