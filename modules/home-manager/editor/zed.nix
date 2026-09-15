{
  lib,
  pkgs,
  config,
  ...
}:

with lib;
let
  cfg = config.editor.zed;
in
{
  options.editor.zed.enable = mkEnableOption "Zed";

  config = mkIf cfg.enable {
    stylix.targets.zed.enable = false;
    programs.zed.enable = true;
  };
}
