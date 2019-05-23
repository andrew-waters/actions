FROM hashicorp/terraform:0.12.0

LABEL "com.github.actions.name"="terraform fmt"
LABEL "com.github.actions.description"="Validate terraform files are formatted"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/andrew-waters/actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Andrew Waters <waters@me.com>"

RUN apk --no-cache add jq curl

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
