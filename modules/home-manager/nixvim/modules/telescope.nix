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
              "~/Documents"
              "~/nixos"
            ];
            order_by = "asc";
            search_by = "title";
            mappings = { };
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
        "<leader>ff" = {
          action = "find_files";
          options.desc = "Find project files";
        };

        "<leader>fg" = {
          action = "live_grep";
          options.desc = "Find Lines *Grep";
        };

        "<leader>fs" = {
          action = "treesitter";
          options.desc = "Find Symbols";
        };

        "<leader>fb" = {
          action = "current_buffer_fuzzy_find";
          options.desc = "Find Buffer";
        };

        "<leader>b" = {
          action = "buffers";
          options.desc = "Buffers";
        };

        "<leader>p" = {
          action = "project";
          options.desc = "Projects";
        };

        "<leader>gb" = {
          action = "git_branches";
          options.desc = "Git Branches";
        };

        "<leader>gc" = {
          action = "git_commits";
          options.desc = "Git Commits";
        };

        "<leader>gs" = {
          action = "git_status";
          options.desc = "Git Status";
        };

        "<leader>d" = {
          action = "diagnostics bufnr=0";
          options.desc = "Document Diagnostics";
        };

        "<leader>D" = {
          action = "diagnostics";
          options.desc = "Workspace diagnostics";
        };

        "<leader>H" = {
          action = "help_tags";
          options.desc = "Help pages";
        };

        "<leader>K" = {
          action = "keymaps";
          options.desc = "Keymaps";
        };

        "<leader>M" = {
          action = "man_pages";
          options.desc = "Man pages";
        };
      };
    };
  };
}
