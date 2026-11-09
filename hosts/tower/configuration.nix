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
    ../../modules/system

    inputs.ocular.nixosModules.vpn
    inputs.home-manager.nixosModules.home-manager
  ];

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

  users.users.remote.extraGroups = [ "docker" ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs;
    };
    backupFileExtension = "backup";
    users = {
      "raphael" = import ./home.nix {
        user = "raphael";
        userDir = "/home/raphael";
      };
      "root" = import ./home.nix {
        user = "root";
        userDir = "/root";
      };
      "remote" = import ./home-remote.nix;
    };
  };
}
