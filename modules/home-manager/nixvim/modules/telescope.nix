{ ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;

    extensions = {
      project = {
        enable = true;
        settings = {
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

        mappings = {
          i = {
            "<esc>" = {
              __raw = ''
                function(...)
                  return require("telescope.actions").close(...)
                end'';
            };
          };
        };
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
        options.desc = "Find project files";
      };

      "<leader>o" = {
        action = "git_files";
        options.desc = "Find git files";
      };

      "<leader>s" = {
        action = "live_grep";
        options.desc = "Search";
      };

      "<leader>l" = {
        action = "treesitter";
        options.desc = "Symbols";
      };

      "<C-t>" = {
        action = "todo-comments";
        options.desc = "See Todos";
      };

      "<C-p>" = {
        action = "project";
        options.desc = "Projects";
      };

      "<leader>b" = {
        action = "git_branches";
        options.desc = "Git Branches";
      };

      "<C-b>" = {
        action = "buffers";
        options.desc = "Buffers";
      };

      "<leader>c" = {
        action = "git_commits";
        options.desc = "commits";
      };

      "<leader>g" = {
        action = "git_status";
        options.desc = "Status";
      };

      "<leader>u" = {
        action = "current_buffer_fuzzy_find";
        options.desc = "Buffer";
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

      "<leader>k" = {
        action = "keymaps";
        options.desc = "Keymaps";
      };

      "<leader>M" = {
        action = "man_pages";
        options.desc = "Man pages";
      };

      "<leader>m" = {
        action = "marks";
        options.desc = "Jump to Mark";
      };
    };
  };
}
