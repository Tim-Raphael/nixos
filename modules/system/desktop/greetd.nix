{
  lib,
  pkgs,
  config,
  ...
}:

let
  gnome_enabled = config.desktopEnvironments.gnome.enable or false;
  environments = lib.concatStringsSep "\n" (
    lib.optional config.sway.enable "sway --unsupported-gpu"
    ++ lib.optional config.niri.enable "niri-session"
    ++ lib.optionals gnome_enabled [ "gnome" ]
  );
  defaultSession =
    if config.sway.enable then
      "sway --unsupported-gpu"
    else if config.niri.enable then
      "niri-session"
    else
      "gnome";
in
{
  config = lib.mkIf (config.sway.enable || config.niri.enable || gnome_enabled) {

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.tuigreet}/bin/tuigreet \
                      --time \
                      --asterisks \
                      --user-menu \
                      --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions \
                      --cmd "${defaultSession}"
          '';
        };
      };
    };

    environment.etc."greetd/environments".text = environments;

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
