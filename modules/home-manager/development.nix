{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gh
    glab
    websocat
    postman
    yarn
    rustup
    cargo-deny
    taplo
    protobuf
    pkg-config
    openssl
    postgresql.dev
    mdl
    lld
    llvm
    clang
    commitlint
    # gcc
    # binutils
    nodejs_23
    pnpm_10
    nodePackages.typescript
    nodePackages.live-server
  ];

  programs.git = {
    enable = true;

    userName = "Tim-Raphael";
    userEmail = "mail@tim-raphael.dev";

    extraConfig = {
      pull = {
        rebase = false;
      };
      core = {
        editor = "nvim";
      };
    };
  };

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = "clang"
    rustflags = ["-C", "link-arg=-fuse-ld=lld"]
  '';
}
