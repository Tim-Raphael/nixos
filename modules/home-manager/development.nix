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

    (mkIf cfg.tools.copilot.enable {
      programs.vscode = {
        enable = true;
        package = pkgs.unstable.vscode;
        profiles.default = {
          extensions = with pkgs.unstable.vscode-extensions; [
            github.copilot
            github.copilot-chat
            vscodevim.vim
          ];
          userSettings = {
            "editor.lineNumbers" = "relative";
            "chat.agent.enabled" = true;
            "chat.defaultMode" = "agent";
            "vim.useSystemClipboard" = true;
            "vim.hlsearch" = true;
            "vim.leader" = "<space>";
          };
        };
      };
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
