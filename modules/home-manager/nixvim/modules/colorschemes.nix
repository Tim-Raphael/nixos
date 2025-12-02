{ lib, config, ... }:

{
  programs.nixvim.colorschemes.base16 = {
    enable = true;

    colorscheme = lib.concatMapAttrs (name: value: {
      ${name} = "#${value}";
    }) config.colorScheme.palette;

    settings = {
      telescope = false;
      telescope_borders = false;
      cmp = true;
    };
  };
}
