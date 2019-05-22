#!/bin/sh
set -e
cd "${TF_ACTION_WORKING_DIR:-.}"

if [[ ! -z "$TF_ACTION_WORKSPACE" ]] && [[ "$TF_ACTION_WORKSPACE" != "default" ]]; then
  terraform workspace select "$TF_ACTION_WORKSPACE"
fi

cp /.terraformrc $GITHUB_WORKSPACE

sed -i "s/TF_TOKEN/$TF_VAR_STATE_TOKEN/g" .terraformrc

exit 0
