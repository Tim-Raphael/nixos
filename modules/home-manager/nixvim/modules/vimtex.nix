{ ... }:

{
  programs.nixvim = {
    plugins.vimtex = {
      enable = true;
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

    extraConfigLua = ''
      -- VimTeX keybinds for tex buffers only
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.keymap.set("n", "<A-.>", "<cmd>VimtexView<CR>", { buffer = true, desc = "VimTeX View" })
          vim.keymap.set("n", "<A-,>", "<cmd>VimtexTocToggle<CR>", { buffer = true, desc = "VimTeX TOC Toggle" })
        end,
      })
    '';
  };
}
