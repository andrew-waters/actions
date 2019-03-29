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

root_path="/go/src/github.com/$GITHUB_REPOSITORY"

echo "Setting up"
mkdir -p $root_path
cp -ar $GITHUB_WORKSPACE/* $root_path/
cd $root_path

curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
chmod +x ./cc-test-reporter

./cc-test-reporter before-build 

echo "Running go test with coverage"
go test -coverprofile=c.out

echo "mode: set" > c.out

./cc-test-reporter after-build
