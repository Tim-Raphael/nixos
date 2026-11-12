{
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.development.direnv;
in
{
  options.development.direnv = {
    enable = mkEnableOption "direnv with nix-direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
