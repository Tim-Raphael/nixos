{
  lib,
  pkgs,
  config,
  ...
}:

with lib;
let
  cfg = config.editor.vscode;
in
{
  options.editor.vscode.enable = mkEnableOption "VS Code";

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
    };
  };
}
