{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.development;
in
{
  imports = [ inputs.opencode.homeModules.default ];

  options.development = {
    tools = {
      enable = mkEnableOption "Development tools for testing and debugging";

      postman.enable = mkEnableOption "Enable Postman";
      websocat.enable = mkEnableOption "Enable Websocat";
      dbBeaver.enable = mkEnableOption "Enable DB-Beaver";
    };

    versionControl = {
      enable = mkEnableOption "Enable tools for version controls";

      git.enable = mkEnableOption "Enable Git";
      jujutsu.enable = mkEnableOption "Enable Jujutsu";
    };

    languages = {
      enable = mkEnableOption "Enable tools for different languages";

      rust = {
        enable = mkEnableOption "Enable Rust";
        lld = mkEnableOption "Use lld as linker";
      };

      markdown.enable = mkEnableOption "Enable Markdown";
      web.enable = mkEnableOption "Enable Web";
      python.enable = mkEnableOption "Enable Python";
      c.enable = mkEnableOption "Enable Clang";
      java.enable = mkEnableOption "Enable Java";
    };

    linkers = {
      enable = mkEnableOption "Enable linkers";

      mold.enable = mkEnableOption "Enable Mold";
      lld.enable = mkEnableOption "Enable lld";
    };

    databases = {
      enable = mkEnableOption "Enable datbases";

      postgresql.enable = mkEnableOption "Enable Postgresql";
    };

    deps = {
      enable = mkEnableOption "Enable dependencies";

      protobuf.enable = mkEnableOption "Enable protobuf";
      pkgConfig.enable = mkEnableOption "Enable pkg-config";
      openssl.enable = mkEnableOption "Enable openssl";
      gcc.enable = mkEnableOption "Enable gcc";
    };
  };

  config = mkMerge [
    # Tools
    (mkIf cfg.tools.postman.enable {
      home.packages = with pkgs; [ postman ];
    })

    (mkIf cfg.tools.websocat.enable {
      home.packages = with pkgs; [ websocat ];
    })

    (mkIf cfg.tools.dbBeaver.enable {
      home.packages = with pkgs; [ dbeaver-bin ];
    })

    # Version Control
    (mkIf cfg.versionControl.jujutsu.enable {
      programs.jujutsu = {
        enable = true;

        settings = {
          user = {
            name = "Tim-Raphael";
            email = "mail@tim-raphael.dev";
          };
          git = {
            push = "origin";
            fetch = [
              "origin"
              "upstream"
            ];
          };
          ui = {
            paginate = "never";
            editor = "nvim";
            default-command = [
              "log"
              "--reversed"
            ];
          };
        };
      };
    })

    (mkIf cfg.versionControl.git.enable {
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
    })

    # Languages
    (mkIf cfg.languages.markdown.enable {
      home.packages = with pkgs; [ mdl ];
    })

    (mkIf cfg.languages.web.enable {
      home.packages = with pkgs; [
        yarn
        pnpm_10
        nodejs
        nodePackages.typescript
        live-server
      ];
    })

    (mkIf cfg.languages.rust.enable {
      home.packages = with pkgs; [
        (rust-bin.stable."1.92.0".default.override {
          extensions = [
            "rust-std"
            "rust-src"
            "rustfmt"
            "rust-analyzer"
          ];
          targets = [ "x86_64-unknown-linux-gnu" ];
        })
        taplo
      ];
    })

    (mkIf cfg.languages.rust.lld {
      home.packages = with pkgs; [ lld ];
      home.file.".cargo/config.toml".text = ''
        [target.x86_64-unknown-linux-gnu]
        linker = "clang"
        rustflags = ["-C", "link-arg=-fuse-ld=lld"]
      '';
    })

    (mkIf cfg.languages.python.enable {
      home.packages = with pkgs; [
        (python3.withPackages (
          ps: with ps; [
            numpy
          ]
        ))
      ];
    })

    (mkIf cfg.languages.c.enable {
      home.packages = with pkgs; [ clang ];
    })

    # Databases
    (mkIf cfg.databases.postgresql.enable {
      home.packages = with pkgs; [ postgresql ];
    })

    # Dependencies
    (mkIf cfg.deps.protobuf.enable {
      home.packages = with pkgs; [ protobuf ];
    })

    (mkIf cfg.deps.pkgConfig.enable {
      home.packages = with pkgs; [ pkg-config ];
    })

    (mkIf cfg.deps.openssl.enable {
      home.packages = with pkgs; [ openssl ];
    })
  ];
}
