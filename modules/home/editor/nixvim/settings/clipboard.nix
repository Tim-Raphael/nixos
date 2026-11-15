{ ... }:

{
  programs.nixvim = {
    clipboard = {
      register = "unnamedplus";
    };
    autoCmd = [
      {
        event = [ "TextYankPost" ];
        callback.__raw = ''
          function()
            vim.highlight.on_yank({higroup='Visual', timeout=100})
          end
        '';
      }
    ];
  };
}
