{ lib, ... }:

{
  programs.nixvim = {
    plugins.oil = {
      enable = true;

      settings = {
        columns = [ "icon" ];

        view_options = {
          show_hidden = true;
        };
      };
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "<C-n>";
        action = "<CMD>Oil<CR>";
        options = {
          desc = "Open parent directory";
        };
      }
    ];
  };
}
