{ config, pkgs, inputs, ... }:

{ 
    imports = [
        ./hardware-configuration.nix
        inputs.home-manager.nixosModules.home-manager

        ./modules/base.nix
        ./modules/bootloader.nix
        ./modules/networking.nix
        ./modules/users.nix
        ./modules/i3.nix
        ./modules/xserver.nix
        ./modules/keyboard.nix
        ./modules/sound.nix
        ./modules/services.nix

        ./packages/editor.nix
        ./packages/development.nix
        ./packages/utils.nix
        ./packages/communication.nix
        ./packages/multimedia.nix
        ./packages/gaming.nix
];

    home-manager = {
        extraSpecialArgs = { inherit inputs; };
        users = {
            "raphael" = import ./modules/home.nix;
        };
    };
}

