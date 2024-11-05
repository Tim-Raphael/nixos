{ config, pkgs, ... }:

{
  # User configuration
  users.users.raphael = {
    isNormalUser = true;
    description = "raphael";
    extraGroups = [ "wheel" "networkmanager" "uinput" ];
    ignoreShellProgramCheck = true;
    shell = pkgs.fish;
  };
}
