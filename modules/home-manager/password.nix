{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.password;
in
{
  options.password = {
    pass.enable = mkEnableOption "Pass cli password manager";
    keepass.enable = mkEnableOption "Keepass password manager";
  };

  config = mkMerge [
    (mkIf cfg.pass.enable {
      home.packages = with pkgs; [
        pass
        gnupg
        pinentry-tty
        git
      ];
    })

    (mkIf cfg.keepass.enable {
      programs.keepassxc = {
        enable = true;
        #autostart = true;
        #settings = {
        #  FdoSecrets.Enabled = true; # Enable Secret Service Integration
        #};
      };
      #xdg.autostart.enable = true; # Enable creation of XDG autostart entries
    })
  ];
}
