FROM golang:1.11

LABEL "com.github.actions.name"="Codeclimate Coverage Reporter"
LABEL "com.github.actions.description"="Report the results of test coverage to codeclimate"
LABEL "com.github.actions.icon"="pie-chart"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/andrew-waters/actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Andrew Waters <waters@me.com>"

RUN \
  apt-get update && \
  apt-get install -y ca-certificates openssl zip && \
  update-ca-certificates && \
  rm -rf /var/lib/apt && \
  go get -u github.com/jteeuwen/go-bindata/... && \
  go get -u github.com/stretchr/testify/assert && \
  go get github.com/axw/gocov/gocov && \
  curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > /usr/local/bin/cc-test-reporter && \
  chmod +x /usr/local/bin/cc-test-reporter

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
