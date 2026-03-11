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
    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/users.nix
    ../../modules/system/security.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/media.nix
    ../../modules/system/ssh.nix
    ../../modules/system/remote-user.nix
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

  ocular.vpn = {
    enable = true;
    peer = vpn.peers.lumen;
    privateKeyFile = "/root/wireguard/keys/lumen.private";
  };

  remoteUser = {
    enable = true;
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAxTlPKWtC6DN8Ii81peVUT4SyKvWGO7smSgK/UCjUO remote"
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
    };
  };
}
