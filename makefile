include .envrc

# ==================================================================================== #
# DEVELOPMENT
# ==================================================================================== #

## run/api: run the cmd/api application
.PHONY: run/bot/test
run/bot/test:
	@sudo go run ./cmd/bot -token=${TEST_TOKEN} -pubkey=${TEST_PUB_KEY} -addr=${TEST_PORT}

.PHONY: run/bot/prod
run/bot/prod:
	@sudo go run ./cmd/bot -token=${TOKEN} -pubkey=${PUB_KEY} -addr=${PORT}

# ==================================================================================== #
# BUILD
# ==================================================================================== #

git_description = $(shell git describe --always --dirty --tags --long)
linker_flags = '-s -X main.version=${git_description}'

## build/api: build the cmd/api application
.PHONY: build/bot
build/bot:
	@echo 'Building cmd/bot...'
	go build -ldflags=${linker_flags} -o=./bin/fatebot ./cmd/fatebot
	GOOS=linux GOARCH=amd64 go build -ldflags=${linker_flags} -o=./bin/linux_amd64/fatebot ./cmd/fatebot