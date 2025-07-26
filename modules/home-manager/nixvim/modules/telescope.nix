{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [ ripgrep ];

    plugins.telescope = {
      enable = true;

      extensions = {
        project = {
          enable = true;
          settings = {
            base_dirs = [
              "~/nixos"
              "~/Documents"
            ];
            order_by = "asc";
            search_by = "title";
            show_workspace = false;
            mappings = {
              default = "change_working_directory";
            };
          };
        };

        fzf-native = {
          enable = true;
          settings = {
            fuzzy = true;
            override_generic_sorter = true;
            override_file_sorter = true;
            case_mode = "smart_case";
          };
        };

        ui-select = {
          enable = true;
          settings = {
            specific_opts = {
              codeactions = true;
            };
          };
        };
      };

      settings = {
        defaults = {
          layout_strategy = "horizontal";
          borderchars = [
            "─"
            "│"
            "─"
            "│"
            "┌"
            "┐"
            "┘"
            "└"
          ];
        };

        pickers = {
          colorscheme = {
            enable_preview = true;
          };

          buffrs = {
            sort_lastused = true;
          };
        };
      };

      keymaps = {
        "<leader>f" = {
          action = "find_files";
          options.desc = "Find Files";
        };

        "<leader>g" = {
          action = "live_grep";
          options.desc = "Grep";
        };

        "<leader>s" = {
          action = "treesitter";
          options.desc = "Symbol Search";
        };

        "<leader>b" = {
          action = "buffers";
          options.desc = "Buffers";
        };

        "<leader>p" = {
          action = "project";
          options.desc = "Projects";
        };

        "<leader>B" = {
          action = "git_branches";
          options.desc = "Git Branches";
        };

        "<leader>C" = {
          action = "git_commits";
          options.desc = "Git Commits";
        };

        "<leader>S" = {
          action = "git_status";
          options.desc = "Git Status";
        };

        "<leader>d" = {
          action = "diagnostics bufnr=0";
          options.desc = "Document Diagnostics";
        };

        "<leader>D" = {
          action = "diagnostics";
          options.desc = "Diagnostics";
        };

        "<leader>H" = {
          action = "help_tags";
          options.desc = "Help Pages";
        };

        "<leader>K" = {
          action = "keymaps";
          options.desc = "Keymaps";
        };

        "<leader>M" = {
          action = "man_pages";
          options.desc = "Man Pages";
        };
      };
    };
  };
}
