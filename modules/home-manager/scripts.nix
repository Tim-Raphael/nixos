{ pkgs, ... }:

{
  home.file = {
    ".local/bin/remote" = {
      source = ./scripts/remote.sh;
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
    ".local/bin/fm" = {
      source = ./scripts/fm.sh;
      executable = true;
    };
    ".local/bin/nt" = {
      source = ./scripts/nt.sh;
      executable = true;
    };
  };
}
