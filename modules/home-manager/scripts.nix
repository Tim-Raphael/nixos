{ pkgs, ... }:

{
  home.file = {
    ".local/bin/remote_nvim" = {
      source = ./scripts/remote_nvim.sh;
      executable = true;
    };
    ".local/bin/volume" = {
      source = ./scripts/volume.sh;
      executable = true;
    };
    ".local/bin/brightness" = {
      source = ./scripts/brightness.sh;
      executable = true;
    };
  };
}
