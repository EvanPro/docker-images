FROM golang:latest

RUN git clone https://github.com/spencergibb/spring-cloud-gateway-bench.git

WORKDIR /go/spring-cloud-gateway-bench/static

ENTRYPOINT ./webserver
