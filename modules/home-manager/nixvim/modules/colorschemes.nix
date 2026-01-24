{
  inputs,
  config,
  pkgs,
  ...
}:

let
  nixColorsLib = inputs.nix-colors.lib.contrib { inherit pkgs; };
  colorScheme = config.colorScheme.palette;
in
{
  programs.nixvim = {
    extraPlugins = [
      (nixColorsLib.vimThemeFromScheme {
        scheme = config.colorScheme;
      })
    ];

    extraConfigVim = ''
      function! s:patch_color_scheme()
        " Modern Tree-sitter (@-style) highlight groups
        " These are the minimal essential groups for correct syntax highlighting

        " Variables and identifiers
        hi @variable                guifg=#${colorScheme.base05} guibg=NONE gui=NONE guisp=NONE
        hi @variable.builtin        guifg=#${colorScheme.base08} guibg=NONE gui=italic guisp=NONE
        hi @variable.parameter      guifg=#${colorScheme.base05} guibg=NONE gui=NONE guisp=NONE
        hi @variable.member         guifg=#${colorScheme.base05} guibg=NONE gui=NONE guisp=NONE

        " Constants
        hi @constant.builtin        guifg=#${colorScheme.base09} guibg=NONE gui=italic guisp=NONE

        " Modules and namespaces
        hi @module                  guifg=#${colorScheme.base08} guibg=NONE gui=NONE guisp=NONE
        hi @module.builtin          guifg=#${colorScheme.base08} guibg=NONE gui=italic guisp=NONE

        " Properties and fields
        hi @property                guifg=#${colorScheme.base05} guibg=NONE gui=NONE guisp=NONE

        " Functions
        hi @function.builtin        guifg=#${colorScheme.base0D} guibg=NONE gui=italic guisp=NONE
        hi @function.call           guifg=#${colorScheme.base0D} guibg=NONE gui=NONE guisp=NONE
        hi @function.method         guifg=#${colorScheme.base0D} guibg=NONE gui=NONE guisp=NONE
        hi @function.method.call    guifg=#${colorScheme.base0D} guibg=NONE gui=NONE guisp=NONE

        " Keywords
        hi @keyword.import          guifg=#${colorScheme.base0D} guibg=NONE gui=NONE guisp=NONE
        hi @keyword.return          guifg=#${colorScheme.base0E} guibg=NONE gui=NONE guisp=NONE
        hi @keyword.operator        guifg=#${colorScheme.base0E} guibg=NONE gui=NONE guisp=NONE
        hi @keyword.conditional     guifg=#${colorScheme.base0E} guibg=NONE gui=NONE guisp=NONE

        " Punctuation
        hi @punctuation.delimiter   guifg=#${colorScheme.base0F} guibg=NONE gui=NONE guisp=NONE
        hi @punctuation.bracket     guifg=#${colorScheme.base05} guibg=NONE gui=NONE guisp=NONE

        " Comments
        hi @comment.documentation   guifg=#${colorScheme.base03} guibg=NONE gui=italic guisp=NONE

        " Strings
        hi @string.documentation    guifg=#${colorScheme.base0B} guibg=NONE gui=NONE guisp=NONE
        hi @string.special.path     guifg=#${colorScheme.base0B} guibg=NONE gui=NONE guisp=NONE
        hi @string.special.symbol   guifg=#${colorScheme.base0B} guibg=NONE gui=NONE guisp=NONE

        " Markup (for markdown, etc.)
        hi @markup.strong           guifg=NONE guibg=NONE gui=bold guisp=NONE
        hi @markup.italic           guifg=NONE guibg=NONE gui=italic guisp=NONE
        hi @markup.heading          guifg=#${colorScheme.base0D} guibg=NONE gui=bold guisp=NONE
        hi @markup.link.url         guifg=#${colorScheme.base09} guibg=NONE gui=underline guisp=NONE

        " Tags (HTML/XML)
        hi @tag.attribute           guifg=#${colorScheme.base0A} guibg=NONE gui=NONE guisp=NONE
        hi @tag.delimiter           guifg=#${colorScheme.base0F} guibg=NONE gui=NONE guisp=NONE
      endfunction 

      autocmd! ColorScheme nix-${config.colorScheme.slug} call s:patch_color_scheme()

      colorscheme nix-${config.colorScheme.slug}
    '';
  };
}
