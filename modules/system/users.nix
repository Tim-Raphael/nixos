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
      "vboxusers"
      "kvm"
      "adbusers"
      "docker"
    ];
    ignoreShellProgramCheck = true;
    shell = pkgs.fish;
  };
}
