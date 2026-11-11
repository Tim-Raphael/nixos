{
  pkgs,
  inputs,
  ...
}:

{
  system.stateVersion = "25.05";

  imports = [
    ./hardware-configuration.nix
    ../../modules/system/default.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs;
    };
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
