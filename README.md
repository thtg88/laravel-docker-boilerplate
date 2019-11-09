# Laravel Docker Boilerplate
This project provides a boilerplate for a Laravel application within a Docker container.

This project is inspired by the video tutorial ["Create a local Laravel dev environment with Docker
"](https://www.youtube.com/watch?v=5N6gTVCG_rw) by [Andrew Schmelyun](https://twitter.com/aschmelyun)

## Table Of Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
    - [Using `docker-compose`](#using-docker-compose)
    - [Using `Makefile`](#using-makefile)
- [Stack](#stack)
- [Versioning](#versioning)
- [License](#license)

## Requirements
This project requires [Docker Desktop](https://www.docker.com/products/docker-desktop).

## Installation
Clone this project:
```bash
git clone https://github.com/thtg88/laravel-docker-boilerplate.git laravel-app
```

## Usage
You can either use the standard [`docker-compose`](#using-docker-compose) commands, or you can use some pre-defined [`make` ones](#using-makefile)

Your application will be available at http://localhost:8800.

Once your app us ready, please amend your `DB_HOST` in your `.env` file like so:
```
DB_HOST=mysql
```

### Using `docker-compose`
Re-initialize the git repo:
```bash
rm -rf .git
rm -f src/.keep
rm -f .gitignore
touch .gitignore
echo "mysql/*" >> .gitignore
echo "!mysql/.keep" >> .gitignore
git init
```

Boot up the docker container:
```bash
docker-compose build && docker-compose up -d
```

Your application will be available at http://localhost:8800.

And finally create a Laravel app:
```bash
docker-compose exec php composer create-project --prefer-dist laravel/laravel .
```

To stop your container, run:
```bash
docker-compose down
```

### Using `Makefile`
A [`Makefile`](Makefile) is provided if your system support it, with some default commands, which abstract the whole setup.

`make init` will re-initialize the git repository, boot up the Docker container, create the Laravel app, and commit the code for you.
You will now simply have to push to your git remote of choice.

`make start` will boot the Docker container. Your application will be available at http://localhost:8800.

`make stop` will stop the Docker container.

`make start` will restart the Docker container.

`make setup` will create the Laravel app.

## Stack
This project provides the following stack:
- Nginx using the [`nginx:stable-alpine`](https://github.com/nginxinc/docker-nginx/blob/0ad6faa0790f423fb239f2b8800dc339d763869a/stable/alpine/Dockerfile) image
- MySQL 5.7.22 using the `mysql:5.7.22` image
- PHP 7.2 FPM using the [`php:7.2-fpm-alpine`](https://github.com/docker-library/php/blob/af0a051a02c4f3245752e118e9a0da8c8e291107/7.2/alpine3.10/fpm/Dockerfile) image
- Composer, PDO, and PDO MySQL get installed within the build of PHP in the [`Dockerfile`](Dockerfile)

## Versioning

Laravel Docker Boilerplate is maintained under [the Semantic Versioning guidelines](http://semver.org/).

See the [changelog](CHANGELOG.md) of the project for changelogs for each release version.

## License

Code released under [the MIT license](LICENSE).
