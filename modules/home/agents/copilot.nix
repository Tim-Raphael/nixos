{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.agents.copilot;
in
{
  options.agents.copilot.enable = mkEnableOption "GitHub Copilot CLI";

  config = mkIf cfg.enable {
    # Copilot CLI frequently ships breaking changes; track unstable to stay current.
    programs.github-copilot-cli = {
      enable = true;

      package = pkgs.unstable.github-copilot-cli;

      context = ./context.md;
    };
  };
}
