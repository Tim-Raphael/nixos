{ config, ... }:

{
  programs.nixvim.plugins.lualine = {
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
                local hl = vim.api.nvim_get_hl(0, { name = "ModeMsg" }) or {}
                local fg = hl.fg or 0xffffff  -- fallback to white
                return { fg = string.format("#%06x", fg) }
              end
            '';
          }

          {
            __unkeyed = "filename";
            path = 0;
            shorting_target = 40;
            symbols = {
              modified = "[+]";
              readonly = "[-]";
              unnamed = "[No Name]";
              newfile = "[New]";
            };
          }

          {
            __unkeyed = "lsp_status";
            icon = "";
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
              error = "E: ";
              warn = "W: ";
              info = "I: ";
              hint = "H: ";
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

          { __unkeyed = "branch"; }
        ];
      };

      extensions = [ ];
    };
  };
}
