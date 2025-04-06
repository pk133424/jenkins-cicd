FROM golang:1.23.2-alpine AS builder

WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -a -o blog_crud_api main.go

# Create a minimal image
FROM alpine:latest

WORKDIR /app

# Install necessary packages
RUN apk --no-cache add ca-certificates tzdata

# Copy binary from builder
COPY --from=builder /app/blog_crud_api .

# Set timezone
ENV TZ=UTC

# Expose port
EXPOSE 8080

# Run the application
CMD ["/app/blog_crud_api"]