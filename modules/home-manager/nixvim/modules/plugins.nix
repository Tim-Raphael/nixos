{ lib, ... }:

{
  programs.nixvim = {
    plugins = {
      twilight.enable = true;
      aerial.enable = true;
      lz-n.enable = true;
      indent-o-matic.enable = true;
      web-devicons.enable = true;
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "tf";
        action = "<cmd>Twilight<CR>";
        options = {
          desc = "Toggle Focus-Mode";
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "ta";
        action = "<cmd>AerialToggle<CR>";
        options = {
          desc = "Toggle Aerial";
          noremap = true;
          silent = true;
        };
      }
    ];
  };
}
