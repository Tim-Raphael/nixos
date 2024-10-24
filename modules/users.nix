{ config, pkgs, ... }:

{
    # User configuration
    users.users.raphael = {
        isNormalUser = true;
        description = "raphael";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.fish;
    };
}
