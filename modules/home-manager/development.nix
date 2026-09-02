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
      programs.claude-code = {
        enable = true;

        package = pkgs.unstable.claude-code;

        context = ''
          # Code
          - Always structure your code in an easy-to-read sequential order instead of
            finding a clever, concise solution
          - Keep your comments short
          - Never use comments to explain what your code does
          - Use comments to explain why your code does something if additional
            context is required to understand it 
          - Always think about how to verify the changes you are planning to
            make, e.g., do we have tests for the code path I'm touching
          - Separate I/O-bound paths of your code from the rest
            implementations for your tests
          - Provide mock implementations for I/O bound logic which should be
            utilized during test (using crates like faux and httpmock)
          - Only use traits if multiple real implementations are expected
          - Do not program to an interface

          # Writing
          - Never use ":" or "—" in a sentence
          - Every sentence that you write should contain information
          - Always adhere to technical writing best-practices 
        '';

        settings = {
          env = {
            # The login shell is fish, which Claude Code cannot drive. It only
            # accepts an override whose path contains "bash" or "zsh", and
            # falls back to probing /bin and /usr/bin otherwise.
            CLAUDE_CODE_SHELL = "${pkgs.bashInteractive}/bin/bash";
          };
          permissions = {
            defaultMode = "auto";
          };
          includeCoAuthoredBy = false;
          model = "sonnet";
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
            condition = "gitdir:~/wksp/gh/";
            path = "~/wksp/gh/.gitconfig";
          }
          {
            condition = "gitdir:~/wksp/ot/";
            path = "~/wksp/ot/.gitconfig";
          }
        ];
      };
    })
  ];
}
