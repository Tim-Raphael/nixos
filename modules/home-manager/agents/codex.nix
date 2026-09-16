{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.agents.codex;
in
{
  options.agents.codex.enable = mkEnableOption "Codex CLI";

  config = mkIf cfg.enable {
    # Codex frequently ships breaking changes; track unstable to stay current.
    programs.codex = {
      enable = true;

      package = pkgs.unstable.codex;

      context = ./context.md;
    };
  };
}
