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

echo "[ACTION INFO] Setting up"
mkdir -p $ROOT_PATH
cp -a $GITHUB_WORKSPACE/* $ROOT_PATH/
cd $ROOT_PATH

echo "[ACTION INFO] Running go test"
CGO_ENABLED=0 GOOS=linux go test ./...
