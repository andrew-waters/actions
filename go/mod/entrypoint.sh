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
  echo "[ACTION INFO] go.mod exists, continuing"
  if [ -d "vendor" ] ; then
    echo "[ACTION INFO] vendor dir exists, skipping"
  else
    echo "[ACTION INFO] vendor dir not present - running 'go mod vendor'"
    go mod vendor
  fi
else
  echo "[ACTION INFO] go.mod does not exist, nothing to do"
fi
