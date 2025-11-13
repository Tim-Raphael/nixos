{ pkgs, ... }:

{
  home.file = {
    ".local/bin/pre-commit" = {
      source = ./pre-commit.sh;
      executable = true;
    };
    ".local/bin/volume" = {
      source = ./volume.sh;
      executable = true;
    };
    ".local/bin/fm" = {
      source = ./fm.sh;
      executable = true;
    };
    ".local/bin/nt" = {
      source = ./nt.sh;
      executable = true;
    };
    ".local/bin/system-update" = {
      source = ./system-update.sh;
      executable = true;
    };
  };
}
