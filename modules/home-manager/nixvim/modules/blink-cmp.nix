{ ... }:

{
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        completion.list.selection.preselect = false;
        keymap.preset = "enter";
      };
    };
  };
}
