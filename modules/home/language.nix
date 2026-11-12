{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # C
    gcc
    gnumake

    # Python
    pkgs.python3

    # Rust
    rust-bin.stable."1.95.0".default

    # Web
    nodejs
    pnpm_10
    typescript
  ];
}
