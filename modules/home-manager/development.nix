{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tig
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
    pnpm_10
    nodejs
    pre-commit
    postgresql
    postgresql.lib
    pgadmin4-desktopmode
  ];

  programs.git = {
    enable = true;

    userName = "Tim-Raphael";
    userEmail = "mail@tim-raphael.dev";

    includes = [
      {
        condition = "gitdir:~/Documents/work/";
        path = "~/Documents/work/.gitconfig";
      }
    ];

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
