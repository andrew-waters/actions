#!/bin/sh
set -e
cd "${TF_ACTION_WORKING_DIR:-.}"


merged=$(jq --raw-output .pull_request.merged "$GITHUB_EVENT_PATH")

if [ "$merged" == "true" ]; then

    set +e
    OUTPUT=$(sh -c "terraform apply -no-color -input=false -auto-approve $*" 2>&1)
    SUCCESS=$?
    echo "$OUTPUT"
    set -e

    if [ $SUCCESS -eq 0 ]; then
        exit 0
    fi

    if [ "$TF_ACTION_COMMENT" = "1" ] || [ "$TF_ACTION_COMMENT" = "false" ]; then
        exit $SUCCESS
    fi

    COMMENT="#### \`terraform apply\` Failed
    \`\`\`
    $OUTPUT
    \`\`\`"
    PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
    COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
    curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

    exit $SUCCESS

else

    echo "Not merged, exiting"
    exit 0

fi
