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
    (rust-bin.stable.latest.default.override {
      extensions = [
        "rust-std"
        "rust-src"
        "rustfmt"
        "rust-analyzer"
      ];
      targets = [ "x86_64-unknown-linux-gnu" ];
    })
    taplo

    # Python
    (python3.withPackages (
      ps: with ps; [
        numpy
      ]
    ))

    # C
    clang

    # Java
    javaPackages.compiler.openjdk25

    #Linker
    mold
    lld

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

    settings = {
      user = {
        name = "Tim-Raphael";
        email = "mail@tim-raphael.dev";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      core = {
        editor = "nvim";
      };
      push = {
        default = "current";
      };
    };

    includes = [
      {
        condition = "gitdir:~/Documents/work/";
        path = "~/Documents/work/.gitconfig";
      }
    ];
  };

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = "clang"
    rustflags = ["-C", "link-arg=-fuse-ld=lld"]
  '';
}
