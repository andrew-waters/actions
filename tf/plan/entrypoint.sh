#!/bin/sh

# wrap takes some output and wraps it in a collapsible markdown section if
# it's over $TF_ACTION_WRAP_LINES long.
wrap() {
  if [[ $(echo "$1" | wc -l) -gt ${TF_ACTION_WRAP_LINES:-20} ]]; then
    echo "
<details><summary>Show Output</summary>

\`\`\`diff
$1
\`\`\`

</details>

"
else
    echo "

\`\`\`diff
$1
\`\`\`

"
fi
}

set -e

cd "${TF_ACTION_WORKING_DIR:-.}"

echo 1

if [[ ! -z "$TF_ACTION_TFE_TOKEN" ]]; then
  cat > ~/.terraformrc << EOF
credentials "${TF_ACTION_TFE_HOSTNAME:-app.terraform.io}" {
  token = "$TF_ACTION_TFE_TOKEN"
}
EOF
fi

echo 2

if [[ ! -z "$TF_ACTION_WORKSPACE" ]] && [[ "$TF_ACTION_WORKSPACE" != "default" ]]; then
  terraform workspace select "$TF_ACTION_WORKSPACE"
fi

echo 3

set +e
OUTPUT=$(sh -c "TF_IN_AUTOMATION=true terraform plan -no-color -input=false $*" 2>&1)
SUCCESS=$?
echo "$OUTPUT"
set -e

echo 4
echo $TF_ACTION_COMMENT

if [ "$TF_ACTION_COMMENT" = "1" ] || [ "$TF_ACTION_COMMENT" = "false" ]; then
    exit $SUCCESS
fi

echo 5

# Build the comment we'll post to the PR.
COMMENT=""
if [ $SUCCESS -ne 0 ]; then
    echo 6

    OUTPUT=$(wrap "$OUTPUT")
    COMMENT="#### \`terraform plan\` Failed
$OUTPUT

*Workflow: \`$GITHUB_WORKFLOW\`, Action: \`$GITHUB_ACTION\`*"
else

    echo 7


    # Remove "Refreshing state..." lines by only keeping output after the
    # delimiter (72 dashes) that represents the end of the refresh stage.
    # We do this to keep the comment output smaller.
    if echo "$OUTPUT" | egrep '^-{72}$'; then
        OUTPUT=$(echo "$OUTPUT" | sed -n -r '/-{72}/,/-{72}/{ /-{72}/d; p }')
    fi

    # Remove whitespace at the beginning of the line for added/modified/deleted
    # resources so the diff markdown formatting highlights those lines.
    OUTPUT=$(echo "$OUTPUT" | sed -r -e 's/^  \+/\+/g' | sed -r -e 's/^  ~/~/g' | sed -r -e 's/^  -/-/g')

    # Call wrap to optionally wrap our output in a collapsible markdown section.
    OUTPUT=$(wrap "$OUTPUT")

    COMMENT="#### \`terraform plan\` Success
$OUTPUT

*Workflow: \`$GITHUB_WORKFLOW\`, Action: \`$GITHUB_ACTION\`*"
fi

echo 8

# Post the comment.
PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

echo 9

exit $SUCCESS
