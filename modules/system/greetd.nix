{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.sway}/bin/sway --config 
          exec ${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway; swaymsg exit"
        '';
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    sway 
  '';
}
