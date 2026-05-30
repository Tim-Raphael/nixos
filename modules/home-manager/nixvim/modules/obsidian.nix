{ ... }:

{
  programs.nixvim.plugins.obsidian = {
    enable = true;
    settings = {
      legacy_commands = false;
      workspaces = [
        {
          name = "notes";
          path = "~/wksp/notes";
        }
      ];

      templates = {
        folder = "templates";
      };

      frontmatter.enable = false;
      ui.enable = false;
    };
  };
}
