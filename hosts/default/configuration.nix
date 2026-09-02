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
    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/users.nix
    ../../modules/system/security.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/media.nix
    ../../modules/system/dconf.nix
    ../../modules/system/ssh.nix
    ../../modules/system/terminal.nix
    inputs.home-manager.nixosModules.home-manager
  ];

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
