{
  description = "Rust dev shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, rust-overlay, ... }:
    let
      # Keep the system list explicit; add architectures as needed.
      systems = [ "x86_64-linux" ];
      forSystems = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      devShells = forSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
          };

          toolchain = pkgs.rust-bin.stable."1.92.0".default.override {
            extensions = [
              "rust-std"
              "rust-src"
              "rustfmt"
              "rust-analyzer"
            ];
            targets = [ "x86_64-unknown-linux-gnu" ];
          };
        in
        {
          default = pkgs.mkShell {
            packages = [
              toolchain
              pkgs.taplo
              pkgs.pkg-config
              pkgs.openssl
              pkgs.protobuf
              # `lld` was previously wired in globally via ~/.cargo/config.toml.
              # Kept per-project via env vars below so it doesn't leak into
              # non-flake shells.
              pkgs.clang
              pkgs.lld
            ];

            # Match the old `home.file.".cargo/config.toml"` linker override
            # without touching the user's home. Cargo picks these up per shell.
            env = {
              CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER = "clang";
              RUSTFLAGS = "-C link-arg=-fuse-ld=lld";
              # pkg-config finds openssl et al.
              PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
            };
          };
        }
      );
    };
}
