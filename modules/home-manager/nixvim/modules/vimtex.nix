{ ... }:

{
  programs.nixvim.plugins.vimtex = {
    enable = true;

    # TODO: Lazy load this (on command)

    texlivePackage = null; # Use system texlive
    settings = {
      view_method = "zathura";
      compiler_method = "latexmk";
      compiler_latexmk = {
        options = [
          "-file-line-error"
          "-synctex=1"
          "-interaction=nonstopmode"
        ];
      };
    };
  };
}
