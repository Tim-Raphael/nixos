{ pkgs, ... }:

let
  visual-star-search = pkgs.vimUtils.buildVimPlugin {
    pname = "visual-star-search";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "bronson";
      repo = "vim-visual-star-search";
      rev = "master";
      sha256 = "sha256-Cx1Ev4S7d/3Re3GfU+jmMlikhyQB8o5sGUX4zRdBdrw=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ visual-star-search ];

    plugins.spectre.enable = true;

    keymaps = [
      # No Highlighting
      {
        key = "<leader>h";
        mode = "n";
        action = ":nohlsearch<CR>";
        options.desc = "No Highlighting";
      }
      {
        key = "<leader>h";
        mode = "v";
        action = ":nohlsearch<cr>";
        options.desc = "no highlighting";
      }
      # Replacing
      {
        key = "<leader>r";
        action = ":s///g<Left><Left>";
        options.desc = "Replace All";
      }
      {
        key = "<leader>rc";
        action = ":s///gc<Left><Left><Left>";
        options.desc = "Replace All (Confirm)";
      }
      # Spectre
      {
        key = "<leader>/";
        action = "<cmd>lua require(\"spectre\").toggle()<CR>";
        options.desc = "Search";
      }
    ];
  };
}
