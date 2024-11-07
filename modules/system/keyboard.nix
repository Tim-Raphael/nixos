{ config, pkgs, ... }:

{
  # access keyboard configuration
  hardware.keyboard.qmk.enable = true;

  # Console keymap
  console.keyMap = "de";
}
