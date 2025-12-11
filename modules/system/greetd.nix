{
  lib,
  pkgs,
  config,
  ...
}:

let
  gnome_enabled = config.desktopEnvironments.gnome.enable or false;
  environments = lib.concatStringsSep "\n" ([ "sway" ] ++ lib.optionals gnome_enabled [ "gnome" ]);
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
                    --time \
                    --asterisks \
                    --user-menu \
                    --cmd sway'';
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
}
