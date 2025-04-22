{
  pkgs,
  inputs,
  nix-colors,
  ...
}:

let
  maybeSettings = if builtins.pathExists ./settings.nix then [ ./settings.nix ] else [ ];
in
{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

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
    ../../modules/system/sound.nix
    ../../modules/system/printer.nix
    ../../modules/system/ssh.nix
    ../../modules/system/virtualisation.nix
    ../../modules/system/terminal.nix
    ../../modules/system/printer.nix
    ../../modules/system/ssh.nix
    ../../modules/system/greetd.nix

    inputs.home-manager.nixosModules.home-manager
  ] ++ maybeSettings;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit nix-colors;
    };
    users = {
      "raphael" = import ./home.nix;
    };
  };
}
