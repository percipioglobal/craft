# percipioglobal/craft Change Log

## 1.3.2 - Unreleased

- Made docker more performant
- Updated webpack 5
- Added go-live checklist
- Added _macros/functions and moved function from _macros/utilities over
- Added _atoms/buttons (cta, group, primary, secondary, tertiary and variables) to add global button styling and grouping of buttons
- Added _atoms/chips (group, skills and variables) to add global label like components and group those labels
- Added _atoms/dates (variables)
- Expanded _atoms/images with partner to add branding partners
- Updated _atoms/images (article, cover, hero, logo, profile, teaser and variables) to make it more intuitive and better parsing of variables
- Added _atoms/links (home and partner)
- Added _atoms/texts (standfirst and variables) to make it more intuitive
- Added placeholders to the global variables
- Added custom cookie
- Updated _molecules/cards/card--highlight to match up with the atoms
- Added _molecules/images/image--gallery for a basic masonry two gridded gallery
- Updated all the builders to match op with the new eagerBeaver
- Updated _organisms/entry-types/page--content with the meta in comment
- Updated css/utilities/aspect-ratios with basic styling to fit the image and added isFilled

## 1.3.1 - Unreleased

- Made docker more performant
- Added queue shell script
- Made builds with Tailwind much more performant
- Return back to Vue 2.0
- Added root vendor folder to `.gitignore`

## 1.3.0 - Unreleased

### Added
- Added in the Tailwind Typography plugin with a few standard settings
- Added Typescript support
- Use Vue.js 3.0
- Added buddy.yml for atomic deployments
- Added ESLint support
- Added native image lazy loading
- Slim Docker containers after build
- Added init to the docker-compose.yml to processes are sent signals
- Added `--no-tablespaces` to the mysqldump command options to work around changes in MySQL
- Added a queue component with a longer ttr
- Added a queue docker container to run queue jobs via ./craft queue/listen
- Added image optimizers to the php-dev-craft Docker image

### Changed
- Changed the Font Awesome Pro packages to the Free alternatives and updated all of their values
- Replaced moment with vanilla Javascript
- Replaced `getenv()` with `App::env()`
- Boilerplate now requires craftcms/cms ^3.5.9
- Refactor composer scripts to handle Craft not being installed, leveraging craft install/check
- Remove `[hash]` from dev config to eliminate potential [memory errors](https://github.com/webpack/webpack-dev-server/issues/438)
- Use `[contenthash]` in production instead of [hash or chunkhash](https://github.com/webpack/webpack.js.org/issues/2096)
- Better nginx config for local dev, based on nystudio107/nginx
- Removed dotenvy
- Updated the css-loader config to ignore embedded URLs
- Changed project-config/sync -> project-config/apply
- Updated the buddy.yaml with the latest Prep Craft script

### Fixed
- Fixed wrong template handle for errors to `error`
- Fixed AMP template layouts path
- Fixed wrong paths into `errors templates`
- Fixed `baseUrl` wrong alias
- Refactored Docker config to use more sane contexts during builds, speeding up build time immensely 🎩 Patrick
- Change throwExceptions deprecator config to use App::env('DEV_MODE')
- Fix redis session config to use App::sessionConfig()
- Modern config only for local dev, [fixing multi-compiler issues](https://github.com/webpack/webpack-dev-server/issues/2355) with HRM

## 1.2.2 - 22-07-2020

### Added
- Added ARIA compliant labels to the image atoms [#25](https://github.com/percipioglobal/craft/issues/25)
- Added `typogrify.php` config file [#23](https://github.com/percipioglobal/craft/issues/23)

### Changed
- Updated twig tags to discard whitespace in image atoms
- Updated `Simple.json` redactor config to give the user more control over their content [#22](https://github.com/percipioglobal/craft/issues/22)
- Updated `Content.json` redactor config to give the user more control over their content [#18](https://github.com/percipioglobal/craft/issues/18)
- Improved field order on resources block [#21](https://github.com/percipioglobal/craft/issues/21)
- Renamed SEOMatic to SEO for better authoring experience [#20](https://github.com/percipioglobal/craft/issues/20)
- Renamed Retour to Redirects for better authoring experience [#19](https://github.com/percipioglobal/craft/issues/19)

## 1.2.1.2 - 16-07-2020

### Fixed
- Fixed redundant mutationSharer `setNavigation` from shared Mutations

## 1.2.1.1 - 16-07-2020

### Fixed
- Fixed missing `createLoadingState` in app.js

## 1.2.1 - 16-07-2020

### Added
- Vuex Persisted State
- Vuex Shared Mutations

### Fixed
- Fixed missing Fort-Awesome Packages
- Fixed missing Vue-Wait package

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
