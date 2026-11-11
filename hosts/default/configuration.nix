{ hardwareProfile, ... }:

{
  system.stateVersion = "25.05";

  imports = [
    # `nixos-generate-config` writes this profile to /etc/nixos on the target
    # machine, and flake.nix passes that path in. The profile check swaps in
    # checks/hardware-profile.nix, since pure evaluation cannot read /etc.
    hardwareProfile
    ../../modules/system/default.nix
  ];
}
