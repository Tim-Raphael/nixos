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
    ../../modules/system/default.nix
    inputs.ocular.nixosModules.vpn
    inputs.home-manager.nixosModules.home-manager
  ];

  local.workServices.enable = true;

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
    };
  };
}
