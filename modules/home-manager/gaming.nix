{ pkgs, ... }:

{
  home.packages = with pkgs; [
    beyond-all-reason
    pcsx2
    minecraft
    prismlauncher
  ];
}
