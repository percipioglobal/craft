# percipioglobal/craft Change Log

## 1.2.0 - 14-07-2020

### Added
- Added Resources List Organism / Molecule
- Added FAQ List Organism / Molecule
- Added structure for Article Molecules
- Added template for detail pages
- Added Font Awesome File Type Icons
- Added more Eager Loaded fields

### Changed
- Updated `seed_db.sql`
- Updated News Cards with Profile Photo + Author
- Updated content-image with more options + overrides
- Macro `design-system.twig` has been changed to `utilities.twig`

### Fixed
- Fixed article block fieldhandle [#12](https://github.com/percipioglobal/craft/issues/12)
- Fixed wrong ENV variables for CloudFront URL [#10](https://github.com/percipioglobal/craft/issues/10)
- Fixed Image Block [#11](https://github.com/percipioglobal/craft/issues/11)
- Fixed Resources Block [#13](https://github.com/percipioglobal/craft/issues/13)
- Fixed mysql command not running on db backup [#14](https://github.com/percipioglobal/craft/issues/14)
- Fixed issue where profile photos were using the wrong optimisation field
- Fixed `text-deca` classnames to use `text-4xl` according to tailwind standards

## 1.1.3 - 03-07-2020

### Added
- Created News Categories
- Created FAQ Categories [#8](https://github.com/percipioglobal/craft/issues/8)
- Created FAQ Channel [#8](https://github.com/percipioglobal/craft/issues/8)
- Added FAQ List to Content Builder [#8](https://github.com/percipioglobal/craft/issues/8)
- Created template file + variables for FAQ List [#8](https://github.com/percipioglobal/craft/issues/8)
- Added redactor field for answer section of the FAQ [#8](https://github.com/percipioglobal/craft/issues/8)

### Changed
- Updated `seed_db.sql` [#8](https://github.com/percipioglobal/craft/issues/8)

### Fixed
- Fixed where Highlight Cards wouldn't show, added them to the correct group in spoon

## 1.1.2.1 - 02-07-2020

### Fixed
- Made sure header and footer template is in the correct folder [#9](https://github.com/percipioglobal/craft/issues/9)

## 1.1.2 - 01-07-2020

### Added
- Added Verbb navigation plugin
- Added Blitz Recommendations
- Added Navigation Structure
- Added Profile Images Volume
- Added Optimization field for Profile Images
- Added navigation configuration file

### Changed
- Changed System Timezone
- Updated User Settings
- Updated Development Settings

### Fixed
- Fixed wrong field under Landing Page Entry
- Fixed wrong section type for Pages from Channel to Structure

## 1.1.1 - 30-06-2020

### Changed
- Updated readme with Craft CLI execution command information

### Fixed
- Made sure the `project.yaml` and `seed_db.sql` are synced

## 1.1.0 - 30-06-2020

### Added
- Added LinkField Plugin
- Added SuperTable Plugin
- Added Vuex for JS data stores
- Added Lazysizes for lazyloading images
- Added Picturefill to polyfill responsive images
- Added Moment.js
- Added Date Formatting Atom / Macro
- Added HTML Structure for Cards
- Added Single Image Atom including Aspect Ratios
- Added PullQuote / BlockQuote molecule
- Added container for the content builder
- Added more tracking environment variables
- Added Spoon Integration for Field structures
- Added Resource List as part of our Stacked Lists Molecules
- Added new 8by5 aspect ratio to match with Image Optimize standard settings
- Added Content.json config for redactor, which excludes the use of images or videos within the text field

### Changed
- MySQL port binding changed to 4306 so it doesn't conflict with possible localhost installs
- Changed the header and the footer to be part of the organisms folder
- Updated projact.yaml to install the plugins
- Updated `seed_db.sql`

### Fixed
- Removed unused pages specific CSS
- Removed webfonts.pcss for the build
- Fixed Cloudfront URL issues
- Fixed `craft` executable permissions
- Fixed schema version in project config

## 1.0.3 - 03-06-2020

### Added
- Added Eager Beaver Plugin

### Changed
- Updated projact.yaml to install the plugins
- Updated `seed_db.sql`

### Fixed
- Fixed `craft` executable permissions
- Fixed schema version in project config.

## 1.0.2 - 03-06-2020
### Fixed
- Fixed scripts file permissions
- Made the setting up steps simpler

## 1.0.1 - 03-06-2020
### Added
- Added `seed_db.sql`
- Added `project.yaml`

## 1.0.0 - 03-06-2020
### Added
- Initial Release

Brought to you by [Percipio Global](https://percipio.london/)