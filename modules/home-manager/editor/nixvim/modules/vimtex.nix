{ ... }:

{
  programs.nixvim.plugins.vimtex = {
    enable = true;
    texlivePackage = null;

    settings = {
      view_method = "zathura";
      compiler_method = "latexmk";
      syntax_enable = true;
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
