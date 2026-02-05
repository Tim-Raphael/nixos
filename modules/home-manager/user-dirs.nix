{ config, ... }:

let
  homeDirectory = config.home.homeDirectory;
in
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${homeDirectory}/dskt";
    documents = "${homeDirectory}/docs";
    download = "${homeDirectory}/dwnl";
    music = "${homeDirectory}/musc";
    pictures = "${homeDirectory}/pics";
    videos = "${homeDirectory}/vids";
    templates = "${homeDirectory}/tmpl";
    publicShare = "${homeDirectory}/publ";
  };
}
