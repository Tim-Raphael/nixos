{ config, pkgs, ... }:

{
  # User configuration
  users.users.raphael = {
    isNormalUser = true;
    description = "raphael";
    extraGroups = [
      "wheel"
      "networkmanager"
      "vboxusers"
      "kvm"
      "adbusers"
      "docker"
      "podman"
      "input"
      "uinput"
    ];
    ignoreShellProgramCheck = true;
    shell = pkgs.fish;
  };
}
