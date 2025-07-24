{ lib, ... }:

{
  programs.nixvim = {
    plugins = {
      twilight.enable = true;
      aerial.enable = true;
      lz-n.enable = true;
      indent-o-matic.enable = true;
      neogit.enable = true;
      web-devicons.enable = true;
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "ff";
        action = "<cmd>Twilight<CR>";
        options = {
          desc = "Toggle Focus-Mode";
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "fa";
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
