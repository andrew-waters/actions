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
mkdir -p $ROOT_PATH
cp -r $GITHUB_WORKSPACE/. $ROOT_PATH
cd $ROOT_PATH

GIT_COMMIT_SHA=$GITHUB_SHA
GIT_BRANCH=$GITHUB_REF

cc-test-reporter before-build

echo "[ACTION INFO] Running go test with coverage"
for pkg in $(go list ./... | grep -v main); do
    go test -coverprofile=$(echo $pkg | tr / -).cover $pkg
done
echo "mode: set" > c.out
grep -h -v "^mode:" ./*.cover >> c.out
rm -f *.cover

cc-test-reporter after-build
