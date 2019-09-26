#!/bin/bash

set -xe

# Make sure the user running the
# tests is the Gotenberg user.
CURRENT_USER=$(whoami)
if [ "$CURRENT_USER" != "gotenberg" ]; then
    exit 1
fi

# Start the PM2 processes 
# (Google Chrome headless & unoconv listener).
# TODO just start chrome
go run github.com/thecodingmachine/gotenberg/test/cmd/pm2

# Run our tests.
if [ "$CODE_COVERAGE" = "1" ]; then
    go test -race -coverprofile=coverage.txt -covermode=atomic ./...
else
    go test -race -cover ./...
fi