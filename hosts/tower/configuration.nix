{
  pkgs,
  inputs,
  ...
}:

let
  vpn = inputs.ocular.lib.vpn;
in
{
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/users.nix
    ../../modules/system/security.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/media.nix
    ../../modules/system/ssh.nix
    ../../modules/system/nix-ld.nix
    ../../modules/system/android.nix
    ../../modules/system/dconf.nix
    ../../modules/system/steam.nix
    ../../modules/system/terminal.nix
    ../../modules/system/virtualisation.nix
    ../../modules/system/ssh.nix
    ../../modules/system/greetd.nix
    ../../modules/system/opentabletdriver.nix
    ../../modules/system/android.nix
    ../../modules/system/desktop-environment.nix

    inputs.ocular.nixosModules.vpn
    inputs.home-manager.nixosModules.home-manager
  ];

  programs.wireshark.enable = true;
  environment.systemPackages = with pkgs; [ wireshark ];

  ocular.vpn = {
    enable = true;
    peer = vpn.peers.lumen;
    privateKeyFile = "/root/wireguard/keys/lumen.private";
  };

  users.remote = {
    enable = true;
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINJI8PUBN58NGVjS+rGLber2B0CBSAFA96DsfHGxv+WD raphael" # Work
    ];
  };

  desktopEnvironments.gnome.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs;
    };
    backupFileExtension = "backup";
    users = {
      "raphael" = import ./home.nix;
      "remote" = import ./home-remote.nix;
    };
  };
}
