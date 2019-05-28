#!/bin/sh
set -e
cd "${TF_ACTION_WORKING_DIR:-.}"

if [[ ! -z "$TF_ACTION_TFE_TOKEN" ]]; then
  cat > ~/.terraformrc << EOF
credentials "${TF_ACTION_TFE_HOSTNAME:-app.terraform.io}" {
  token = "$TF_ACTION_TFE_TOKEN"
}
EOF
fi

set +e
OUTPUT=$(sh -c "terraform workspace new $TF_ACTION_WORKSPACE" 2>&1)
SUCCESS=$?
echo "$OUTPUT"
set -e

exit $SUCCESS
