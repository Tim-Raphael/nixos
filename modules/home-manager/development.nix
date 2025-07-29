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

    # Markdown
    mdl

    # Web
    yarn
    pnpm_10
    nodejs
    nodePackages.typescript
    live-server

    # Rust
    (rust-bin.selectLatestNightlyWith (
      toolchain:
      toolchain.default.override {
        extensions = [
          "rust-src"
        ];
        targets = [ "x86_64-unknown-linux-gnu" ];
      }
    ))
    taplo

    # C
    clang

    #Linker
    mold
    #lld

    # DB
    postgresql
    dbeaver-bin

    # Misc
    protobuf
    pkg-config
    openssl
    #gcc
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
    rustflags = ["-C", "link-arg=-fuse-ld=mold"]
  '';
}
