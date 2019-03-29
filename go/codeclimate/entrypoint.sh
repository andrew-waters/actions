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

echo "GITHUB_REPOSITORY:"
echo $GITHUB_REPOSITORY

root_path="/go/src/github.com/$GITHUB_REPOSITORY"

echo $root_path

mkdir -p $root_path

echo "cp -r $GITHUB_WORKSPACE $root_path"
cp -r $GITHUB_WORKSPACE/. $root_path
cd $root_path

GIT_COMMIT_SHA=$GITHUB_SHA
echo $GIT_COMMIT_SHA
GIT_BRANCH=$GITHUB_REF
echo $GIT_BRANCH


ls -la

# echo "cc-test-reporter before-build"
#cc-test-reporter before-build

echo "Running go test with coverage"
go test -coverprofile=c.out

echo "Tests completed"
echo "mode: set" > c.out

ls -la

cat c.out

cc-test-reporter format-coverage -c.out -t gocov

ls -la

cd coverage

ls -la


cc-test-reporter upload-coverage


# echo "Running ./cc-test-reporter after-build"
# ./cc-test-reporter after-build
