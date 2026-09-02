{ lib, ... }:

# Stand-in for the hardware profile that `nixos-generate-config` writes to
# /etc/nixos on the target machine. The bootstrap host imports that file by
# absolute path, which no CI runner has, so the profile check evaluates the host
# against this module instead. It declares the few options a NixOS evaluation
# insists on and nothing else.

{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  swapDevices = [ ];
}
