{
  pkgs,
  inputs,
  ...
}:

let
  maybeSettings = if builtins.pathExists ./settings.nix then [ ./settings.nix ] else [ ];
in
{
  system.stateVersion = "25.05";

  imports = [
    ./hardware-configuration.nix
    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/dconf.nix
    ../../modules/system/users.nix
    ../../modules/system/security.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/media.nix
    ../../modules/system/printer.nix
    ../../modules/system/ssh.nix
    ../../modules/system/virtualisation.nix
    ../../modules/system/terminal.nix
    ../../modules/system/printer.nix
    ../../modules/system/ssh.nix
    ../../modules/system/greetd.nix
    inputs.home-manager.nixosModules.home-manager
  ]
  ++ maybeSettings;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs;
    };
    users = {
      "raphael" = import ./home.nix;
    };
  };
}
