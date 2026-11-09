{
  pkgs,
  inputs,
  hardwareProfile,
  ...
}:

{
  system.stateVersion = "25.05";

  imports = [
    # `nixos-generate-config` writes this profile to /etc/nixos on the target
    # machine, and flake.nix passes that path in. The profile check swaps in
    # checks/hardware-profile.nix, since pure evaluation cannot read /etc.
    hardwareProfile
    ../../modules/system
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs pkgs;
    };
    users = {
      "root" = import ./home.nix {
        inherit pkgs inputs;
        user = "root";
        userDir = "/root";
      };
    };
  };
}
