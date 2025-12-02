{ lib, ... }:

{
  programs.nixvim = {
    plugins = {
      web-devicons = {
        enable = true;
      };

      oil = {
        enable = true;

        lazyLoad = {
          enable = true;

          settings = {
            cmd = "Oil";
            keys = [ "<C-n>" ];
          };
        };

        settings = {
          columns = [ "icon" ];
          view_options = {
            show_hidden = true;
          };
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
