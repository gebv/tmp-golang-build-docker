FROM golang:1.14 AS vendor
    WORKDIR /go/src/github.com/gebv/tmp-golang-build-docker
    COPY go.mod .
    COPY go.sum .
    RUN go mod download
    RUN go env

FROM vendor as builder
    WORKDIR /go/src/github.com/gebv/tmp-golang-build-docker
    COPY --from=vendor /go/pkg/mod /go/pkg/mod
    COPY . .

    RUN CGO_ENABLED=0 go build -v -o ./bin/app ./cmd/main.go

FROM alpine:3.11 as app
    WORKDIR /
    COPY --from=builder /go/src/github.com/gebv/tmp-golang-build-docker/bin/app .
    ENTRYPOINT /app --flagname=build
