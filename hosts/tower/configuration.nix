{ pkgs, inputs, nix-colors; ... }:

{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager

    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix
    ../../modules/system/users.nix
    ../../modules/system/xserver.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/sound.nix
    ../../modules/system/ssh.nix
    ../../modules/system/android.nix
    ../../modules/system/steam.nix
    ../../modules/system/terminal.nix
    ../../modules/system/virtualisation.nix
  ];

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
