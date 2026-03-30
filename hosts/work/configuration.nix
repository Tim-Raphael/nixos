{
  pkgs,
  inputs,
  ...
}:

let
  vpn = inputs.ocular.lib.vpn;
in
{
  system.stateVersion = "25.05";

  imports = [
    ./hardware-configuration.nix
    ./vpn.nix

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

    inputs.ocular.nixosModules.vpn
    inputs.home-manager.nixosModules.home-manager
  ];

  programs.wireshark.enable = true;

  ocular.vpn = {
    enable = true;
    peer = vpn.peers.void;
    privateKeyFile = "/root/wireguard/keys/void.private";
  };

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
