#!/bin/sh
set -e
cd "${TF_ACTION_WORKING_DIR:-.}"

set +e
OUTPUT=$(sh -c "terraform workspace new $TF_ACTION_WORKSPACE" 2>&1)
SUCCESS=$?
echo "$OUTPUT"
set -e

exit $SUCCESS
