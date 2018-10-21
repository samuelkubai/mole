.PHONY: help
PROJECT_NAME ?= mole
DOCKER_SERVER_DEV_COMPOSE := docker/dev/server/docker-compose.yml
DOCKER_CLIENT_DEV_COMPOSE := docker/dev/client/docker-compose.yml
DOCKER_TEST_COMPOSE_FILE := docker/tests/docker-compose.yml
TARGET_MAX_CHAR_NUM=10
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '${YELLOW} make ${RESET} ${GREEN}<target> [options]${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		message = match(lastLine, /^## (.*)/); \
		if (message) { \
			command = substr($$1, 0, index($$1, ":")-1); \
			message = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} %s\n", command, message; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@echo ''

# Start the local API development server container
local-server:
	@ ${INFO} "Building required docker images"
	@ docker-compose -f $(DOCKER_SERVER_DEV_COMPOSE) build server
	@ ${INFO} "Build Completed successfully"
	@ echo " "
	@ ${INFO} "Starting local development server"
	@ docker-compose -f $(DOCKER_SERVER_DEV_COMPOSE) up server

# Start the local client development server container
local-client:
	@ ${INFO} "Building required docker images"
	@ docker-compose -f $(DOCKER_CLIENT_DEV_COMPOSE) build client
	@ ${INFO} "Build Completed successfully"
	@ echo " "
	@ ${INFO} "Starting local development client"
	@ docker-compose -f $(DOCKER_CLIENT_DEV_COMPOSE) up client

## Stop local development server containers
server-stop:
	${INFO} "Stop server development service"
	@ docker-compose -f $(DOCKER_SERVER_DEV_COMPOSE) down -v
	${INFO} "Server service stopped successfully"

## Stop local development server containers
client-stop:
	${INFO} "Stop client development service"
	@ docker-compose -f $(DOCKER_CLIENT_DEV_COMPOSE) down -v
	${INFO} "Client service stopped successfully"

## Remove all development containers and volumes
clean:
	${INFO} "Cleaning your local environment"
	${INFO} "Note all ephemeral volumes will be destroyed"
	@ docker-compose -f $(DOCKER_SERVER_DEV_COMPOSE) down -v
	@ docker-compose -f $(DOCKER_CLIENT_DEV_COMPOSE) down -v
	@ docker images -q -f label=application=$(PROJECT_NAME) | xargs -I ARGS docker rmi -f ARGS
	${INFO} "Removing dangling images"
	@ docker images -q -f dangling=true -f label=application=$(PROJECT_NAME) | xargs -I ARGS docker rmi -f ARGS
	@ docker system prune
	${INFO} "Clean complete"

## [ service ] Ssh into the API container
server-ssh:
	${INFO} "Open server container terminal"
	@ docker-compose -f $(DOCKER_SERVER_DEV_COMPOSE) exec server bash

## [ service ] Ssh into the client container
client-ssh:
	${INFO} "Open client container terminal"
	@ docker-compose -f $(DOCKER_CLIENT_DEV_COMPOSE) exec client bash

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
NC := "\e[0m"
RESET  := $(shell tput -Txterm sgr0)
# Shell Functions
INFO := @bash -c 'printf "\n"; printf $(YELLOW); echo "===> $$1"; printf $(NC)' SOME_VALUE
SUCCESS := @bash -c 'printf "\n"; printf $(GREEN); echo "===> $$1"; printf $(NC)' SOME_VALUE
