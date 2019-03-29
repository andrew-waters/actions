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

echo $GITHUB_REPOSITORY

root_path="/go/src/github.com/$GITHUB_REPOSITORY"

echo "Setting up"
cp -r $GITHUB_WORKSPACE $root_path
cd $root_path

GIT_COMMIT_SHA=$GITHUB_SHA
echo $GIT_COMMIT_SHA
GIT_BRANCH=$GITHUB_REF
echo $GIT_BRANCH


ls -la

echo "Getting ./cc-test-reporter"
curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
chmod +x ./cc-test-reporter

./cc-test-reporter before-build 

echo "Running go test with coverage"
go test -coverprofile=c.out

echo "Tests completed"
echo "mode: set" > c.out

echo "Running ./cc-test-reporter after-build"
./cc-test-reporter after-build
