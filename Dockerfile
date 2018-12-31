FROM golang:1.11 as builder

MAINTAINER Alan Richert <alan.richert@gmail.com>

RUN curl -s https://glide.sh/get | sh
COPY . /go/src/github.com/cyberaxcess/mongodb_exporter
RUN cd /go/src/github.com/cyberaxcess/mongodb_exporter && make init build

FROM alpine:3.8
EXPOSE 9216

RUN apk add --update ca-certificates
COPY --from=builder /go/src/github.com/cyberaxcess/mongodb_exporter/mongodb_exporter /usr/local/bin/mongodb_exporter

ENTRYPOINT [ "mongodb_exporter" ]
