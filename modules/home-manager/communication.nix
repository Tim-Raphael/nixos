{ pkgs, ... }:

{
  home.packages = with pkgs; [ signal-desktop discord thunderbird ];
}
