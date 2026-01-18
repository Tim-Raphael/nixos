{ lib, pkgs, ... }:

let
  goyo = pkgs.vimUtils.buildVimPlugin {
    pname = "goyo-vim";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "junegunn";
      repo = "goyo.vim";
      rev = "master";
      sha256 = "sha256-pDt7T1U1bqKveAq0CBWTtK2mdOzf8IbfmCi1fcpB2c8=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ goyo ];

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "tw";
        action = "<cmd>Goyo<CR>";
        options = {
          desc = "Toggle writing mode (Goyo)";
        };
      }
    ];
  };
}
