FROM golang:1.14 AS vendor
    WORKDIR /go/src/github.com/gebv/tmp-golang-build-docker
    COPY go.mod .
    COPY go.sum .
    RUN go mod download

FROM vendor as builder
    WORKDIR /go/src/github.com/gebv/tmp-golang-build-docker
    COPY --from=vendor $GOCACHE $GOCACHE
    COPY --from=vendor $GOPATH/pkg/mod $GOPATH/pkg/mod
    COPY . .

    RUN go build -v -race -o ./bin/app ./cmd/main.go

FROM alpine:3.11 as app
    RUN apk update && apk add --no-cache git ca-certificates tzdata make && update-ca-certificates

    WORKDIR /
    COPY --from=builder /go/src/github.com/gebv/tmp-golang-build-docker/bin/app .
    ENTRYPOINT /app
    CMD ["--flagname", "22222222"]
