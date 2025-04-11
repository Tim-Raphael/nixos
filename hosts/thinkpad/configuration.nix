{
  pkgs,
  inputs,
  nix-colors,
  ...
}:

{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  imports = [
    ./hardware-configuration.nix

    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/terminal.nix
    ../../modules/system/virtualisation.nix
    ../../modules/system/users.nix
    ../../modules/system/networking.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/sound.nix
    ../../modules/system/ssh.nix
    ../../modules/system/security.nix
    ../../modules/system/hardware.nix
    ../../modules/system/ssh.nix
    ../../modules/system/greetd.nix

    inputs.home-manager.nixosModules.home-manager
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
