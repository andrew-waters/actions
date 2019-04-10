FROM golang:1.11

LABEL "com.github.actions.name"="go mod"
LABEL "com.github.actions.description"="Run go mod commands for project"
LABEL "com.github.actions.icon"="copy"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="http://github.com/andrew-waters/actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Andrew Waters <waters@me.com>"

RUN \
  apt-get update && \
  apt-get install -y ca-certificates openssl zip && \
  update-ca-certificates && \
  rm -rf /var/lib/apt

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
