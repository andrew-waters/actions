FROM golang:1.11

LABEL "com.github.actions.name"="Go Build"
LABEL "com.github.actions.description"="Build Go binary"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/andrew-waters/actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Andrew Waters <waters@me.com>"

RUN \
  apt-get update && \
  apt-get install -y ca-certificates openssl zip && \
  update-ca-certificates && \
  rm -rf /var/lib/apt

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
