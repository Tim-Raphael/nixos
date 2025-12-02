{ ... }:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "gruvbox-material";
      editor = {
        line-number = "relative";
      };
      keys.normal = { };
    };
  };
}
