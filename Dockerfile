FROM golang

ADD . /go/src/github.com/teran/relay
RUN cd /go/src/github.com/teran/relay && CGO_ENABLED=0 go build -o bin/relay .

FROM alpine

RUN apk add --update --no-cache \
  ca-certificates && \
  rm -vf /var/cache/apk/*
COPY --from=0 /go/src/github.com/teran/relay/bin/relay /relay

ENTRYPOINT ["/relay"]
