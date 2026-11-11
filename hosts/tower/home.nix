{ user, userDir, ... }:

{
  home = {
    stateVersion = "25.11";
    username = user;
    homeDirectory = userDir;
  };

  imports = [ ../../modules/home/default.nix ];
}
