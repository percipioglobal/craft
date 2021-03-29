## About percipioglobal/craft

This is an alternate scaffolding package for Craft 3 CMS projects to Pixel & Tonic's canonical [craftcms/craft](https://github.com/craftcms/craft) package.
 
The project is based on [Craft CMS](https://craftcms.com) using a unique `templates/_boilerplate` system for web/AJAX/AMP pages, and implements a number of technologies/techniques:
 
* [Docker](https://www.docker.com/) Docker is used for local development; see **Setting Up Local Dev** below for details
* A base Twig templating setup as described in [An Effective Twig Base Templating Setup](https://nystudio107.com/blog/an-effective-twig-base-templating-setup)
* [webpack](https://webpack.js.org/) is used for the build system as per [An Annotated webpack 4 Config for Frontend Web Development](https://nystudio107.com/blog/an-annotated-webpack-4-config-for-frontend-web-development)
* [TypeScript](https://www.typescriptlang.org/) for strictly typed JavaScript code
* [Vue.js 3.0](https://vuejs.org/) is used for some of the interactive bits on the website, and Vue.js 3.x allows us to leverage the [Composition API](https://composition-api.vuejs.org/) 
* [Tailwind CSS](https://tailwindcss.com/) for the site-wide CSS
* JSON-LD structured data as per [Annotated JSON-LD Structured Data Examples](https://nystudio107.com/blog/annotated-json-ld-structured-data-examples)
* [Google AMP](https://developers.google.com/amp/) versions of the podcast episode and other pages
* Image transforms are done via a [Serverless Image Handler](https://aws.amazon.com/solutions/serverless-image-handler/) lambda function, as described in the [Setting Up Your Own Image Transform Service](https://nystudio107.com/blog/setting-up-your-own-image-transform-service) article
* Static assets are stored in AWS S3 buckets with CloudFront as the CDN, as per the [Setting Up AWS S3 Buckets + CloudFront CDN for your Assets](https://nystudio107.com/blog/using-aws-s3-buckets-cloudfront-distribution-with-craft-cms) article
* Implements a Service Worker via Google's [Workbox](https://developers.google.com/web/tools/workbox/) as per [Service Workers and Offline Browsing](https://nystudio107.com/blog/service-workers-and-offline-browsing)
* Critical CSS as per [Implementing Critical CSS on your website](https://nystudio107.com/blog/implementing-critical-css)
* Frontend error handling as per [Handling Errors Gracefully in Craft CMS](https://nystudio107.com/blog/handling-errors-gracefully-in-craft-cms)
* A custom site module as per [Enhancing a Craft CMS 3 Website with a Custom Module](https://nystudio107.com/blog/enhancing-a-craft-cms-3-website-with-a-custom-module)
* CLI-based queue as per [Robust queue job handling in Craft CMS](https://nystudio107.com/blog/robust-queue-job-handling-in-craft-cms)
* FastCGI Static Cache as per [Static Page Caching with Craft CMS](https://nystudio107.com/blog/static-caching-with-craft-cms)
* [buddy.works](http://buddy.works/) atomic deployments

...and probably a bunch of other stuff too.

The following Craft CMS plugins are used on this site:
* [AWS S3](https://github.com/craftcms/aws-s3) - adding Amazon S3 volume type 
* [Feed Me](https://github.com/craftcms/feed-me) - to import entries and entry data from XML, RSS or ATOM feeds.
* [Redactor](https://github.com/craftcms/redactor) - Edit rich text content using Redactor by Imperavi.
* [Mailgun](https://github.com/craftcms/mailgun) - Mailgun mailer adapter for Craft CMS
* [Width Fieldtype](https://github.com/hybridinteractive/craft-width-fieldtype) - adds the posibility to choose from predefined widths
* [Position Fieldtype](https://github.com/hybridinteractive/craft-position-fieldtype) - Adds a position fieldtype
* [FastCGI Cache Bust](https://github.com/nystudio107/craft-fastcgicachebust) - to bust the FastCGI cache whenever entries are modified
* [ImageOptimize](https://github.com/nystudio107/craft-imageoptimize) - for the optimized images and `srcset`s used on the site
* [Minify](https://github.com/nystudio107/craft-minify) - to minify the HTML and inline JS/CSS
* [Retour](https://github.com/nystudio107/craft-retour) - for setting up 404 redirects
* [Eager Beaver](https://github.com/nystudio107/craft-eager-beaver) - to handle eager loading on entry pages
* [SEOmatic](https://github.com/nystudio107/craft-seomatic) - for handling site-side SEO
* [Twigpack](https://github.com/nystudio107/craft-twigpack) - for loading webpack-generated `manifest.json` resources in a modern way
* [Typogrify](https://github.com/nystudio107/craft-typogrify) - for smart quotes and other typographic ligatures
* [Webperf](https://github.com/nystudio107/craft-webperf) - for monitoring web performance
* [Password Policy](https://github.com/percipioglobal/craft-password-policy) - for adding password policies
* [Notifications](https://github.com/percipioglobal/craft-notifictions) - for handling system notifications
* [Super Table](https://github.com/verbb/super-table) - Field Type to create powerful tables
* [Spoon](https://github.com/angell-co/Spoon) - Organising our matrix fields
* [Navigation](https://github.com/verbb/navigation) - Managing Navigation Menus

## Using percipioglobal/craft

This project package works exactly the way Pixel & Tonic's [craftcms/craft](https://github.com/craftcms/craft) package works; you create a new project by first creating & installing the project:

    `composer create-project percipioglobal/craft PATH`

Make sure that `PATH` is the path to your project, including the name you want for the project, e.g.:

    `composer create-project percipioglobal/craft craft3`

## Setting Up Local Dev

You'll need Docker desktop for your platform installed to run the project in local development

* Set up a `.env` file in the `cms/` directory, based off of the provided `example.env`
* Set up a `.env.sh.` file in the `scripts/` directory, based off of the provided `example.env.sh`
* Start up the site by typing make dev in terminal in the project's root directory (the first build will be somewhat lengthy)
* Navigate to http://localhost:8000 to use the site; the webpack-dev-server runs off of http://localhost:8080

The CP login credentials are initially set as follows:

Login: `support@percipio.london` \
Password: `letmein`

Obviously change these to whatever you like as needed.

Build the production assets by typing make build to build the critical CSS, fonts, and other production assets. They will appear in `cms/web/dist/` (just double-click on the `report-legacy.html` and `report-modern.html` files to view them).

**Important:** To find the correct credentials for `LOCAL_DB_CONTAINER` run `docker-compose up` and once the docker container is running, use the command `docker container ls` to find the correct name of the container.
If your project is called `test` the container will be somewhere along the lines of `test_mariadb` or `test_mysql`. That's the value you do have to enter.

**N.B.:** Without authorization & credentials (which are private), the `./docker_pull_db.sh` will not work. It's provided here for instructional purposes

## Makefile Project Commands

This project uses Docker to shrink-wrap the devops it needs to run around the project.

To make using it easier, we're using a Makefile and the built-in `make` utility to create local aliases. You can run the following from terminal in the project directory:

- `make dev` - starts up the local dev server listening on `http://localhost:8000/`
- `make build` - builds the static assets via the webpack 5 buildchain
- `make clean` - shuts down the Docker containers, removes any mounted volumes (including the database), and then rebuilds the containers from scratch
- `make composer xxx` - runs the `composer` command passed in, e.g. `make composer install`
- `make npm xxx` - runs the `npm` command passed in, e.g. `make npm install`
- `make pulldb` - runs the `scripts/docker_pull_db.sh` script to pull a remote database into the database container; the `scripts/.env.sh` must be set up first
- `make restoredb xxx` - runs the `scripts/docker_restore_db.sh` script to restore a local database dump into the database container; the `scripts/.env.sh` must be set up first

To use Xdebug with VSCode install the [PHP Debug extension](https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug ) and use the following configuration:
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9001,
            "log": true,
            "externalConsole": false,
            "pathMappings": {
                "/var/www/project/cms": "${workspaceRoot}/cms"
            },
            "ignore": ["**/vendor/**/*.php"]
        }
    ]
}
```

## Running Craft CLI commands

Since we are using docker to run our project, we need to execute the craft CLI commands prepended with the docker command `docker-compose exec php`, eg: `docker-compose exec php ./craft project-config/sync`.

## Updating Composer Packages

To update to the latest Composer packages (as constrained by the `cms/composer.json` semvers), do: 

`docker-compose exec php composer update`

or 

```
rm cms/composer.lock
make dev
```


## Updating NPM Packages

To update to the latest npm packages (as constrained by the `buildchain/package.json` semvers), do:

`docker-compose exec webpack npm update`

or 

```
rm buildchain/package-lock.json
make dev
```

Below is the entire intact, unmodified `README.md` from Pixel & Tonic's [craftcms/craft](https://github.com/craftcms/craft):

.....

<p align="center"><a href="https://craftcms.com/" target="_blank"><img width="312" height="90" src="https://craftcms.com/craftcms.svg" alt="Craft CMS"></a></p>

## About Craft CMS 

Craft is a flexible and scalable CMS for creating bespoke digital experiences on the web and beyond.

It features:

- An intuitive Control Panel for administration tasks and content creation.
- A clean-slate approach to content modeling and [front-end development](https://docs.craftcms.com/v3/dev/).
- A built-in Plugin Store with hundreds of free and commercial [plugins](https://plugins.craftcms.com/).
- A robust framework for [module and plugin development](https://docs.craftcms.com/v3/extend/).

Learn more about it at [craftcms.com](https://craftcms.com).

## Tech Specs

Craft is written in PHP (7+), and built on the [Yii 2 framework](https://www.yiiframework.com/). It can connect to MySQL (5.5+) and PostgreSQL (9.5+) for content storage.

## Installation

See the following documentation pages for help installing Craft 3:

- [Server Requirements](https://docs.craftcms.com/v3/requirements.html)
- [Installation Instructions](https://docs.craftcms.com/v3/installation.html)
- [Upgrading from Craft 2](https://docs.craftcms.com/v3/upgrade.html)

## Popular Resources

- **[Documentation](http://docs.craftcms.com/v3/)** – Read the official docs.
- **[Guides](https://craftcms.com/guides)** – Follow along with the official guides.
- **[#craftcms](https://twitter.com/hashtag/craftcms)** – See the latest tweets about Craft.
- **[Discord](https://craftcms.com/discord)** – Meet the community.
- **[Stack Exchange](http://craftcms.stackexchange.com/)** – Get help and help others.
- **[CraftQuest](https://craftquest.io/)** – Watch unlimited video lessons and courses.
- **[Craft Link List](http://craftlinklist.com/)** – Stay in-the-know.
- **[nystudio107 Blog](https://nystudio107.com/blog)** – Learn Craft and modern web development.