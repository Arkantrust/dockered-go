# syntax=docker/dockerfile:1

FROM golang:1.22.0-alpine3.19 AS modules

WORKDIR /app

# Download Go modules
COPY go.mod go.sum ./
RUN go mod download

FROM modules AS build

# Copy src code
COPY *.go ./

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /ping

FROM build as testing

RUN go test -v ./...

FROM gcr.io/distroless/base-debian12 AS runtime

WORKDIR /

COPY --from=build /ping /ping

EXPOSE 8080

USER nonroot:nonroot

# Run
CMD [ "/ping" ]
