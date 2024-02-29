# syntax=docker/dockerfile:1

# TODO: use 1.22.0-alpine3.19
# Tested with 1.16-buster
FROM golang:1.16-buster AS modules

WORKDIR /app

# Download Go modules
COPY go.mod go.sum ./
RUN go mod download

FROM modules AS build

# Copy src code
COPY *.go ./

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /ping

FROM gcr.io/distroless/base-debian12 AS runtime

WORKDIR /

COPY --from=build /ping /ping

EXPOSE 8080

USER nonroot:nonroot

# Run
CMD [ "/ping" ]
