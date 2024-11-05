{ pkgs, inputs, ... }:

{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager

    ../../overlays/nvim.nix

    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix
    ../../modules/system/users.nix
    ../../modules/system/xserver.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/sound.nix
    ../../modules/system/services.nix

    ../../modules/system/packages/terminal.nix
    ../../modules/system/packages/kanata.nix
    ../../modules/system/packages/steam.nix
    ../../modules/system/packages/ollama.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "raphael" = import ./home.nix; };
  };
}
