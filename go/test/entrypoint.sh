#!/bin/bash

set -e

if [[ -z "$GITHUB_WORKSPACE" ]]; then
  echo "Set the GITHUB_WORKSPACE env variable."
  exit 1
fi

if [[ -z "$GITHUB_REPOSITORY" ]]; then
  echo "Set the GITHUB_REPOSITORY env variable."
  exit 1
fi

ROOT_PATH="/go/src/github.com/$GITHUB_REPOSITORY"

echo "Setting up"
mkdir -p $ROOT_PATH
cp -a $GITHUB_WORKSPACE/* $ROOT_PATH/
cd $ROOT_PATH

if [ -f go.mod ]; then
  if [ ! -d "vendor" ] ; then
    echo "Running go mod download"
    go mod download
  fi
fi

echo "Running go test"
CGO_ENABLED=0 GOOS=linux go test ./...
