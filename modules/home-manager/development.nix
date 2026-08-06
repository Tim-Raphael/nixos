{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.development;
in
{
  options.development = {
    tools = {
      enable = mkEnableOption "Development tools for testing and debugging";

      postman.enable = mkEnableOption "Enable Postman";
      websocat.enable = mkEnableOption "Enable Websocat";
      dbBeaver.enable = mkEnableOption "Enable DB-Beaver";
      claudeCode.enable = mkEnableOption "Enable Claude Code CLI";
      copilot.enable = mkEnableOption "Enable VS Code with GitHub Copilot";
      zed.enable = mkEnableOption "Enable Zed";
    };

    versionControl = {
      enable = mkEnableOption "Enable tools for version controls";

      git.enable = mkEnableOption "Enable Git";
      jujutsu.enable = mkEnableOption "Enable Jujutsu";
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

    # Claude Code frequently ships breaking changes; track unstable to stay current.
    (mkIf cfg.tools.claudeCode.enable {
      home.packages = [ pkgs.unstable.claude-code ];
    })

    (mkIf cfg.tools.zed.enable (
      let
        # Zed downloads these servers itself by default, but the prebuilt
        # binaries assume an FHS layout and fail to start on NixOS. Pin ours
        # by absolute path so Zed spawns a linker-correct binary instead.
        languageServers = {
          rust-analyzer = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          nixd = "${pkgs.nixd}/bin/nixd";
          clangd = "${pkgs.clang-tools}/bin/clangd";
          pyright = "${pkgs.pyright}/bin/pyright-langserver";
          vtsls = "${pkgs.vtsls}/bin/vtsls";
          eslint = "${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server";
          "vscode-css-language-server" = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
          "yaml-language-server" = "${pkgs.yaml-language-server}/bin/yaml-language-server";
          "tailwindcss-language-server" = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
          "bash-language-server" = "${pkgs.bash-language-server}/bin/bash-language-server";
          lua-language-server = "${pkgs.lua-language-server}/bin/lua-language-server";
          taplo = "${pkgs.taplo}/bin/taplo";
        };
      in
      {
        stylix.targets.zed.enable = false;

        programs.zed-editor = {
          enable = true;

          # Grammars and server wiring for languages Zed lacks in core.
          extensions = [
            "nix"
            "toml"
            "lua"
            "html"
            "dockerfile"
          ];

          # Formatters are called by name, and the Claude Code bridge shells
          # out to `claude`, so both need to be on Zed's PATH.
          extraPackages = with pkgs; [
            rust-analyzer
            nixd
            clang-tools
            pyright
            vtsls
            vscode-langservers-extracted
            yaml-language-server
            tailwindcss-language-server
            bash-language-server
            lua-language-server
            taplo

            nixfmt
            biome
            prettierd
            shfmt

            claude-agent-acp
            unstable.claude-code
          ];

          userSettings = {
            # Match the relative line numbers used in the VS Code setup.
            relative_line_numbers = true;

            # GitHub Copilot inline suggestions. Sign in via the command
            # palette ("copilot: sign in") on first launch.
            features = {
              edit_prediction_provider = "copilot";
            };

            # Drive Claude Code from the agent panel through the ACP bridge so
            # it reuses the CLI's existing subscription auth, no API key needed.
            agent_servers = {
              "Claude Code" = {
                command = "${pkgs.claude-agent-acp}/bin/claude-agent-acp";
                args = [ ];
                env = { };
              };
            };

            lsp = mapAttrs (_: path: { binary = { inherit path; }; }) languageServers;

            languages = {
              Nix = {
                language_servers = [
                  "nixd"
                  "!nil"
                ];
                formatter = {
                  external = {
                    command = "nixfmt";
                    arguments = [ "-" ];
                  };
                };
              };
            };

            format_on_save = "on";
          };
        };
      }
    ))

    (mkIf cfg.tools.copilot.enable (
      let
        baseFont = 12;
      in
      {
        stylix.targets.vscode.enable = false;

        programs.vscode = {
          enable = true;
          package = pkgs.unstable.vscode;
          profiles.default = {
            extensions = with pkgs.unstable.vscode-extensions; [
              anthropic.claude-code
              github.copilot-chat
              jnoortheen.nix-ide
              rust-lang.rust-analyzer
              llvm-vs-code-extensions.vscode-clangd
              dbaeumer.vscode-eslint
              sumneko.lua
              ms-pyright.pyright
              bradlc.vscode-tailwindcss
              redhat.vscode-yaml
              redhat.java
            ];
            userSettings = {
              "editor.lineNumbers" = "relative";
              "window.zoomLevel" = 2.5;
              "editor.fontSize" = lib.mkForce baseFont;
              "debug.console.fontSize" = lib.mkForce baseFont;
              "markdown.preview.fontSize" = lib.mkForce baseFont;
              "terminal.integrated.fontSize" = lib.mkForce baseFont;
              "chat.editor.fontSize" = lib.mkForce baseFont;
              "editor.minimap.sectionHeaderFontSize" = lib.mkForce (baseFont * 9.0 / 14.0);
              "scm.inputFontSize" = lib.mkForce (baseFont * 13.0 / 14.0);
              "screencastMode.fontSize" = lib.mkForce (baseFont * 56.0 / 14.0);
              "workbench.statusBar.visible" = false;
              "window.menuBarVisibility" = "compact";
              "window.commandCenter" = false;
              "workbench.navigationControl.enabled" = false;
              "workbench.layoutControl.enabled" = false;
              "workbench.browser.showInTitleBar" = false;
            };
          };
        };
      }
    ))

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
          merge-tools.vimdiff = {
            program = "nvim";
            merge-args = [
              "-d"
              "$output"
              "$left"
              "$base"
              "$right"
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
          aliases = {
            sync = [
              "util"
              "exec"
              "--"
              "sh"
              "-c"
              "jj git fetch --remote main@upstream; jj b set main -r main@upstream; jj rebase --skip-emptied -s 'roots(mutable())' -d main@upstream"
            ];
          };
        };
      };
    })

    (mkIf cfg.versionControl.git.enable {
      programs.git = {
        enable = true;
        ignores = [
          ".tmp/"
          ".claude/"
        ];
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
          merge = {
            tool = "vimdiff";
          };
          mergetool = {
            vimdiff.path = "nvim";
            keepBackup = false;
          };
          push = {
            default = "current";
          };
          alias = {
            quicksave = "!f(){ git add . && git commit && git push; };f";
            qs = "!f(){ git add . && git commit && git push; };f";
            savepoint = "!f(){ git add . &&  pre-commit && git commit && git push; };f";
            sp = "!f(){ git add . &&  pre-commit && git commit && git push; };f";
          };
        };
        includes = [
          {
            condition = "gitdir:~/wksp/ot/";
            path = "~/wksp/ot/.gitconfig";
          }
        ];
      };
    })
  ];
}
