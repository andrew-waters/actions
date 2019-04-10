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

cd $GITHUB_WORKSPACE

if [ -f go.mod ]; then
  if [ -d "vendor" ] ; then
    echo "vendor dir exists, skipping"
  else
    echo "vendor dir not present - running `go mod download`"
    go mod download
  fi
fi
