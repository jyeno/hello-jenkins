FROM nixos/nix:latest

# Copy Nix configuration files
COPY flake.nix flake.lock ./

# Enter development shell and build
RUN nix develop --command zig version

WORKDIR /app
COPY . .
RUN nix develop --command zig build

CMD ["/app/zig-out/bin/hello"]
