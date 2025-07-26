{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Git
    tig
    gh
    glab
    pre-commit
    commitlint

    # API
    postman
    websocat

    # Web
    yarn
    pnpm_10
    nodejs
    nodePackages.typescript
    live-server

    # Rust
    unstable.rust-analyzer
    unstable.cargo
    unstable.clippy
    unstable.cargo-deny
    unstable.taplo

    # C
    clang
    # gcc
    # binutils

    # DB
    postgresql
    dbeaver-bin

    # Container
    lazydocker
    podman-compose
    podman-tui

    # Misc
    protobuf
    pkg-config
    openssl
    mdl
    lld
    llvm
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
      push = {
        default = "current";
      };
    };
  };

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = "clang"
    rustflags = ["-C", "link-arg=-fuse-ld=lld"]
  '';
}
