{ ... }:

{
  programs.nixvim.plugins = {
    aerial.enable = true;

    lualine = {
      enable = true;

      settings = {
        options = {
          icons_enabled = true;
          section_separators = "";
          component_separators = "";
        };

        sections = {
          # overwrite defaults
          lualine_a = [ { __unkeyed = ""; } ];
          lualine_b = [ { __unkeyed = ""; } ];
          lualine_y = [ { __unkeyed = ""; } ];
          lualine_z = [ { __unkeyed = ""; } ];

          # left
          lualine_c = [
            {
              __unkeyed.__raw = ''
                function()
                  return '●' 
                end
              '';
              color.__raw = ''
                function()
                  local colors = require('base16-colorscheme').colors

                  local mode_color = {
                      n = colors.base08,      -- red
                      i = colors.base0B,      -- green
                      v = colors.base0D,      -- blue
                      [''] = colors.base0D, -- blue
                      V = colors.base0D,      -- blue
                      c = colors.base0E,      -- magenta
                      no = colors.base08,     -- red
                      s = colors.base09,      -- orange
                      S = colors.base09,      -- orange
                      [''] = colors.base09, -- orange
                      ic = colors.base0A,     -- yellow
                      R = colors.base0F,      -- violet
                      Rv = colors.base0F,     -- violet
                      cv = colors.base08,     -- red
                      ce = colors.base08,     -- red
                      r = colors.base0C,      -- cyan
                      rm = colors.base0C,     -- cyan
                      ['r?'] = colors.base0C, -- cyan
                      ['!'] = colors.base08,  -- red
                      t = colors.base08,      -- red
                  }

                  return { fg = mode_color[vim.fn.mode()] }
                end,
              '';
            }

            {
              __unkeyed = "filename";
            }

            {
              __unkeyed = "aerial";
            }

            {
              __unkeyed = "lsp_status";
              icon = "";
              symbols = {
                spinner = [
                  "⠋"
                  "⠙"
                  "⠹"
                  "⠸"
                  "⠼"
                  "⠴"
                  "⠦"
                  "⠧"
                  "⠇"
                  "⠏"
                ];
                done = "✓";
                separator = " ";
              };
            }

            {
              __unkeyed = "diagnostics";
              sources = [ "nvim_diagnostic" ];
              symbols = {
                error = "⊝ ";
                warn = "⚡ ";
                info = "⊙ ";
                hint = "⟲ ";
              };
            }
          ];

          # right
          lualine_x = [
            {
              __unkeyed = "diff";
              symbols = {
                added = "+";
                modified = "~";
                removed = "-";
              };
            }

            {
              __unkeyed = "branch";
              icon = "";
            }

          ];
        };

        extensions = [ ];
      };
    };
  };
}
