# prevent it getting confused by identically named files
.PHONY : all check start setup

all: check

CMD_DOCKER_COMPOSE := $(shell command -v docker-compose 2> /dev/null)
CMD_ARTISAN := $(shell command -v src/artisan 2> /dev/null)

check:
ifndef CMD_DOCKER_COMPOSE
	$(error "Docker Desktop is required, see https://www.docker.com/products/docker-desktop")
endif

initcheck:
ifdef CMD_ARTISAN
	$(error "Directory 'src' is not empty. Aborting.")
endif

PROJECT_NAME = $(shell basename $$PWD)
PROJECT_NAME_LOWER = $(shell echo $(PROJECT_NAME) | tr A-Z a-z)
PROJECT_NAME_UPPER = $(shell echo $(PROJECT_NAME) | tr a-z A-Z)
PROJECT_NAME_CLASS = $(shell echo $(PROJECT_NAME_LOWER) | perl -pe 's/([^a-zA-Z]|^)(\w)/\U$$2/g')

_gitinit:
	rm -rf .git
	rm -f src/.keep
	rm -f .gitignore
	touch .gitignore
	echo "mysql/*" >> .gitignore
	echo "!mysql/.keep" >> .gitignore
	git init

init: | check initcheck _gitinit restart setup
	git add .
	git commit -m 'Setup $(PROJECT_NAME_CLASS)'

start: check
	docker-compose build
	docker-compose up -d

restart: check stop start

stop: check
	docker-compose down

setup: check
	docker-compose exec php composer create-project --prefer-dist laravel/laravel .
