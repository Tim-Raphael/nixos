{ ... }:

{
  programs.nixvim.plugins.oil = {
      enable = true;

      settings = {
        columns = [ "icon" ];

        view_options = {
          show_hidden = false;
        };
      };
}

