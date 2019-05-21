FROM hashicorp/terraform:0.11.13

LABEL "com.github.actions.name"="terraform apply"
LABEL "com.github.actions.description"="Run terraform apply"
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/andrew-waters/actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Andrew Waters <waters@me.com>"

RUN apk --no-cache add jq

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
