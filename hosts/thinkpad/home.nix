{ user, userDir, ... }:

{
  home = {
    stateVersion = "24.05";
    username = user;
    homeDirectory = userDir;
  };

  imports = [ ../../modules/home/default.nix ];
}
