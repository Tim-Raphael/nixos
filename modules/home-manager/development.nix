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

    (mkIf cfg.tools.copilot.enable (
      let
        baseFont = 12;
      in
      {
        stylix.targets.vscode.enable = false;

        home.packages = with pkgs; [
          nixd
          rust-analyzer
          clang-tools
          vscode-langservers-extracted
          vtsls
          lua-language-server
          pyright
          tailwindcss-language-server
          yaml-language-server
          jdt-language-server
          typos-lsp
        ];

        programs.vscode = {
          enable = true;
          package = pkgs.unstable.vscode;
          profiles.default = {
            extensions = with pkgs.unstable.vscode-extensions; [
              github.copilot-chat
              vscodevim.vim
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
              "chat.agent.enabled" = true;
              "chat.defaultMode" = "agent";
              "vim.useSystemClipboard" = true;
              "vim.hlsearch" = true;
              "vim.leader" = "<space>";
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
        ignores = [ ".tmp/" ];
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
          remote = {
            "upstream" = {
              fetch = "+refs/heads/*:refs/remotes/upstream/*";
            };
            "origin" = {
              fetch = "+refs/heads/*:refs/remotes/origin/*";
            };
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
