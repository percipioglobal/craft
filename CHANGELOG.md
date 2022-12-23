# percipioglobal/craft Change Log

## 4.1.0 - 23/12/2022
### Added
- Vue 3 script setup lang
- Pinia store

### Changed
- Updated templates
- Updated vite from 2 to 3
- Updated content and page builder

## 1.5.0 - 19/10/2021
### Added
- Added tailwind ratio with helper classes
- Added Vue 3
- Added Vuex 4

### Changed
- Updated go-live-checklist.md
- Disabled AMP by default
- Removed cluttered classes from the page--news
- Updated dependencies
- Updated TS shims
- updated `enableGraphQlCaching` --> `enableGraphqlCaching` deprecation change

### Fixed
- Made sure Eager Loading works on the resources organism
- Fixed Lazy Loading tags on the teaser images
- Removed duplicate loading of typography plugin in Tailwind

## 1.4.10 - 23/06/2021

### Changed
- Removed `USER` directive in the PHP containers, since the pool runs as www-data already
- Fix permissions regression
- Continue running the php-fpm containers as root (since php-fpm uses worker pools with the proper user/group), but switch to su-exec to ensure any craft CLI commands are run as www-data

## 1.4.9.1 - 08/06/2021

### Fixed
- Fixed `devServer` --> `server` (╯°□°）╯︵ ┻━┻

## 1.4.9 - 08/06/2021

### Added
- Added `runtime.js` to errorEntry twigpack settings
- Added `cloudfrontUrl` alias to prefetched URLs
- Added `assetsUrl` variable
- Added Makefile

### Changed

- Changed `baseUrl` alias variable to `@web`
- Updated permissions for docker containers
- Updated the `site-fonts.css` file to actually load the included fonts

### Fixed
- Fixed trailing slashes in `.env` example file for `ASSETS_URL` and `SITE_URL`
- Fixed missing placeholder for Hero Images

## 1.4.8 - 12/04/2021

### Fixed
- Fixed wrong fieldName in templates for hero image block
- Fixed missing placeholder for Hero Images

## 1.4.7 - 09/04/2021

### Added
- Added purge rules in the TW config

### Changed
- Updated `tailwind` to `2.1`
- Enabling JIT in the TW config

## 1.4.6 - 30/03/2021

### Changed
- Updated `db-seed/seed.sql` to reflect updates
- Updated project files
- Removed unused ENV var

## 1.4.5 - 29/03/2021

### Added
- Added `make clean` to the Makefile
- Added Makefile Project Commands to `README.md`
- Added `make composer xxx` & `make npm xxx` commands
- Added `make` command aliases

### Changed
- Use official MariaDB images

### Fixed
- Fixed an issue with the `webpack-dev-server` version `^4.0.0-beta.1` by moving the `overlay` config setting to `client` (https://github.com/nystudio107/craft/issues/54)
- Fix webpack buildchain pipeline

## 1.4.4 - 18/03/2021

### Fixed
- Fixed an issue with wrong aliases
- Created the single `app.pcss` needed for Tailwind JIT

## 1.4.3 - 16/03/2021

### Added
- Added Tailwind JIT
- Added file aliasing for the builds
### Changed
- Changed webpack-dev-container to use `node 14-alpine`
- Bumped minimum PHP requirements to `7.4`

### Fixed
- Fixed wrong option for criticalCss, changed `url` to `uri`

## 1.4.2 - 12/03/2021

### Added
- Added on deploy failure slack notification
- Added App ID Support
### Changed
- Updated buddy to use `node-dev-base`
- Changed buddy `npm ci` to `npm install`
### Fixed
- Fixed issue where logo atom wasn't using the correct end tag

## 1.4.1.4 - 01/03/2021

### Changed
- Changed pgsql to mysqli for alpine builds

## 1.4.1.3 - 01/03/2021

### Fixed
- Fixed issue where the buddy production build had `-y` appended to `apk add`
- Fixed issue where the Slack notification was added twice

## 1.4.1.1 / 1.4.1.2 - 18/02/2021

### Fixed
- Fixed issue where case-sensitive machines would see 2 sitemodule folders.

## 1.4.1 - 18/02/2021

### Changed
- Updated favicons to use `6.2.1` which contains an updated version of sharp that should build on M1 Macs
- Updated the position field type to be more compatible with PHP-8
- Made site module PSR-4 compliant

### Fixed
- Fixed a few issues where images could error when using live preview, as no fallback was provided
- Fixed an issue where the description text was white against a white background for the section header
- Fixed the issue where the seed db / project files would have a plaintext field for the image position rather than a position field type

## 1.4.0 - 15/02/2021

### Added
- GTM support on Button atoms
- Support for square images has been added in the Gallery Images organism
- Added social button atoms
- Added Spotlight Cards with the ability to choose how much latest entries you want to display.
- Added a Kitchen Sink Page to show every component in the project.
- Created GitHub Pull Request Templates and Label strategies
- Created a cookie warning/notification component in Vue
- Added go-live checklist
- Added `_macros/functions` and moved function from `_macros/utilities` over
- Added `_atoms/buttons` (cta, group, primary, secondary, tertiary and variables) to add global button styling and grouping of buttons
- Added `_atoms/chips` (group, skills and variables) to add global label like components and group those labels
- Added `_atoms/dates` (variables)
- Added `_atoms/links` (home and partner)
- Added `_atoms/texts` (standfirst and variables) to make it more intuitive
- Added placeholders to the global variables
- Added `_molecules/images/image--gallery` for a basic masonry two column gallery
- Added root vendor folder to `.gitignore`

### Changed
- Made builds with Tailwind much more performant
- Made docker more performant
- Updated containers to alpine php
- Updated containers to now use PHP-8
- Updated Nginx to use version 1.19
- Buddy commands updated to work with the alpine builds
- Updated the buildchain to work fully with webpack 5
- Updated all the builders to match op with the new eagerBeaver
- Updated `_organisms/entry-types/page--content` with the meta in comment
- Updated `css/utilities/aspect-ratios` with basic styling to fit the image and added `isFilled`
- Updated the `config/seomatic-config` according to our company info
- Expanded `_atoms/images` with partner to add branding partners
- Updated `_atoms/images` (article, cover, hero, logo, profile, teaser and variables) to make it more intuitive and better parsing of variables
- Updated `_molecules/cards/card--highlight` to match up with the atoms
- Eager Loading optimisations
- Updated Highlight Cards to fetch specific card types instead of using `card--highlight`
- Updated the styling of some components to have a default version

### Fixed
- Added Teaser optimized to the Teaser asset volume
- Fixed Hero optimiser name in the atom

## 1.3.0 - 15/09/2020

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
