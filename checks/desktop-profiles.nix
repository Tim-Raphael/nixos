{ pkgs, bootstrap }:

let
  checkProfile =
    name: niri: sway:
    let
      profile = bootstrap.extendModules {
        modules = [
          ../modules/system/desktop/greetd.nix
          {
            niri.enable = niri;
            sway.enable = sway;
          }
        ];
      };
      system = profile.config;
      home = system.home-manager.users.root;
      greeter = system.services.greetd.settings.default_session.command or "";
      shared = niri || sway;
    in
    assert system.programs.niri.enable == niri;
    assert system.programs.sway.enable == sway;
    assert home.niri.enable == niri;
    assert home.sway.enable == sway;
    assert home.wayland.windowManager.sway.enable == sway;
    assert home.programs.waybar.enable == niri;
    assert home.programs.fuzzel.enable == niri;
    assert home.programs.wlogout.enable == niri;
    assert home.services.swayidle.enable == niri;
    assert home.services.mako.enable == shared;
    assert system.services.blueman.enable == shared;
    assert home.services.blueman-applet.enable == shared;
    assert
      !shared
      || builtins.any (
        entry: entry.value == "AutoConnect"
      ) home.dconf.settings."org/blueman/general".plugin-list.value;
    assert !shared || home.systemd.user.services.blueman-applet.Unit.Requires == [ ];
    assert home.services.wlsunset.enable == shared;
    assert home.programs.swaylock.enable == shared;
    assert (home.xdg.configFile ? "niri/config.kdl") == niri;
    assert (home.systemd.user.services ? niri-polkit) == niri;
    assert system.services.greetd.enable == shared;
    assert !sway || pkgs.lib.hasInfix "--cmd \"sway --unsupported-gpu\"" greeter;
    assert sway || !niri || pkgs.lib.hasInfix "--cmd \"niri-session\"" greeter;
    {
      inherit name niri sway;
      derivation = builtins.unsafeDiscardStringContext system.system.build.toplevel.drvPath;
    };
  profiles = [
    (checkProfile "sway" false true)
    (checkProfile "niri" true false)
    (checkProfile "both" true true)
    (checkProfile "neither" false false)
  ];
in
assert bootstrap.config.sway.enable;
assert !bootstrap.config.niri.enable;
pkgs.writeText "desktop-profiles.json" (builtins.toJSON profiles)
