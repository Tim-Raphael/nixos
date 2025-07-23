{ lib, config, ... }:

{
  programs.nixvim.colorschemes.base16 = {
    enable = true;

    colorscheme = lib.concatMapAttrs (name: value: {
      ${name} = "#${value}";
    }) config.colorScheme.palette;

    setUpBar = true;

    settings = {
      telescope = false;
      telescope_borders = true;
      indentblankline = false;
      notify = true;
      cmp = true;
    };
  };
}
