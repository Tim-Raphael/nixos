{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.sway.enable = lib.mkEnableOption "Sway desktop" // {
    default = true;
  };

  config = lib.mkIf config.sway.enable {
    programs.sway = {
      enable = true;
      extraOptions = [ "--unsupported-gpu" ];
    };

    xdg.portal = {
      wlr = {
        enable = true;
        settings.screencast = {
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f 'Monitor: %o' -or";
        };
      };
      config.sway = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
    };
  };
}
