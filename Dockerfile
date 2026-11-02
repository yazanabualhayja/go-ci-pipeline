# Stage 1: build a static binary
FROM golang:1.22 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o app .

# Stage 2: copy only the binary into an empty image
FROM scratch
COPY --from=builder /app/app .
EXPOSE 8080
CMD ["./app"]
