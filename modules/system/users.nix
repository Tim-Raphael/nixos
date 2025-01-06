{ config, pkgs, ... }:

{
  # User configuration
  users.users.raphael = {
    isNormalUser = true;
    description = "raphael";
    extraGroups = [
      "wheel"
      "networkmanager"
      "uinput"
      "docker"
      "vboxusers"
      "kvm"
      "adbusers"
    ];
    ignoreShellProgramCheck = true;
    shell = pkgs.fish;
  };
}
