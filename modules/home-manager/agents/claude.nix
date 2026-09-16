{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.agents.claude;
in
{
  options.agents.claude.enable = mkEnableOption "Claude Code CLI";

  config = mkIf cfg.enable {
    # Claude Code frequently ships breaking changes; track unstable to stay current.
    programs.claude-code = {
      enable = true;

      package = pkgs.unstable.claude-code;

      context = ./context.md;

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
  };
}
