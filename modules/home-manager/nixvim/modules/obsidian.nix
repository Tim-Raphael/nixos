{ ... }:

{
  programs.nixvim.plugins.obsidian = {
    enable = true;

    settings = {
      workspaces = [
        {
          name = "Notes";
          path = "~/Documents/notes";
        }
      ];
    };
  };
}
