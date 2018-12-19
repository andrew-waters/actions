FROM golang:1.11-alpine

LABEL "repository" = "https://github.com/andrew-waters/actions"
LABEL "homepage" = "https://github.com/andrew-waters/actions"
LABEL "maintainer" = "Andrew Waters"

LABEL "com.github.actions.name" = "Hugo build"
LABEL "com.github.actions.description" = "Builds a hugo website"
LABEL "com.github.actions.icon" = "target"
LABEL "com.github.actions.color" = ""

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        bash git openssh

RUN go get github.com/spf13/hugo

COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
