{ pkgs, ... }:

{
  home.file = {
    ".local/bin/pre_commit" = {
      source = ./scripts/pre_commit.sh;
      executable = true;
    };
    ".local/bin/volume" = {
      source = ./scripts/volume.sh;
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
