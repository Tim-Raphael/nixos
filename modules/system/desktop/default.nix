{ config, lib, ... }:

{
  imports = [
    ./niri.nix
    ./sway.nix
  ];

  config = lib.mkIf (config.niri.enable || config.sway.enable) {
    services.blueman.enable = true;
  };
}
