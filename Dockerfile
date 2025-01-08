# Dockerfile
FROM alpine:latest AS builder

# Install Zig
RUN apk add --no-cache wget xz \
    && wget -O zig.tar.xz https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz \
    && tar -xf zig.tar.xz \
    && mv zig-linux-x86_64-0.13.0 /usr/local/zig \
    && rm zig.tar.xz

# Add Zig to PATH
ENV PATH="/usr/local/zig:${PATH}"

# Build stage
WORKDIR /build
COPY . .
RUN zig build -Doptimize=ReleaseSafe

# Create minimal runtime image
FROM alpine:latest
RUN ls
COPY --from=builder /build/zig-out/bin/jenkins-topicosweb2 /app/hello
CMD ["/app/hello"]
