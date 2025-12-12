{ ... }:

{
  programs.nixvim.plugins = {
    blink-cmp-dictionary.enable = true;
    blink-cmp-spell.enable = true;
    # TODO: Lazylaod when opening a .tex file.
    blink-cmp-latex.enable = true;

    blink-cmp = {
      enable = true;
      settings = {
        keymap.preset = "enter";
        completion = {
          list.selection = {
            preselect = false;
            auto_insert = false;
          };
        };
        cmdline = {
          completion = {
            menu = {
              auto_show = true;
            };
            list.selection = {
              preselect = false;
              auto_insert = true;
            };
          };
          keymap.preset = "default";
        };
      };
    };
  };
}
