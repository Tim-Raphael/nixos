{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/terminal.nix
    ../../modules/system/virtualisation.nix
    ../../modules/system/users.nix
    ../../modules/system/networking.nix
    ../../modules/system/dconf.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/media.nix
    ../../modules/system/ssh.nix
    ../../modules/system/security.nix
    ../../modules/system/hardware.nix
    ../../modules/system/ssh.nix
    ../../modules/system/greetd.nix
    ../../modules/system/steam.nix
    ../../modules/system/swap.nix

    inputs.home-manager.nixosModules.home-manager
  ];

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
