{ pkgs, inputs, ... }: {

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
    ../../modules/system/services.nix

    ../../overlays/nvim.nix

    ../../modules/packages/editor.nix
    ../../modules/packages/development.nix
    ../../modules/packages/utils.nix
    ../../modules/packages/communication.nix
    ../../modules/packages/multimedia.nix
    ../../modules/packages/gaming.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "raphael" = import ./home.nix; };
  };
}
