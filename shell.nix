{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    zig        # Zig Compiler
    zls        # Zig Language Server
    pre-commit # pre-commit git hook
  ];

  shellHook = ''
    echo "Zig development environment loaded!"
    echo "Zig version: $(zig version)"
    # install pre-commit hooks if not done already
    [ -e .git/hooks/pre-commit ] && pre-commit install
  '';
}

