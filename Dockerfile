FROM golang:1.20.3-alpine3.17 AS builder

# Install dependencies
WORKDIR /go/src/app

# Copy the source code
COPY go.mod ./
RUN go mod download

COPY hello.go ./

# Build the app
RUN CGO_ENABLED=0 go build -o hello ./hello.go

FROM scratch
COPY --from=builder /go/src/app/hello /usr/bin/hello
ENV GIN_MODE=release
CMD ["/usr/bin/hello"]