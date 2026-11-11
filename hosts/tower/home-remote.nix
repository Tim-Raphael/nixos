{ ... }:

{
  home = {
    stateVersion = "25.11";
    username = "remote";
    homeDirectory = "/home/remote";
  };

  imports = [ ../../modules/home/default.nix ];
}
