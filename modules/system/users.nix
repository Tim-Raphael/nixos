{ config, pkgs, ... }:

{
  # User configuration
  users.users.raphael = {
    isNormalUser = true;
    description = "raphael";
    extraGroups = [ "networkmanager" "wheel" ];
    ignoreShellProgramCheck = true;
    shell = pkgs.fish;
  };
}
