{ pkgs, ... }:

{
  home.file = {
    ".local/bin/remote_nvim" = {
      source = ./scripts/remote_nvim.sh;
      executable = true;
    };
  };
}
