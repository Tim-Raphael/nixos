{ ... }:

{
  programs.nixvim = {
    dependencies = {
      ripgrep.enable = true;
      fd.enable = true;
    };

    plugins = {
      telescope = {
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
            layout_strategy = "flex";
            sorting_strategy = "ascending";
            initial_mode = "insert";
            prompt_prefix = " > ";
            selection_caret = " > ";
            entry_prefix = "   ";
            scroll_strategy = "cycle";
            path_display = [ "truncate" ];

            results_title = false;
            preview_title = false;
            dynamic_preview_title = true;

            layout_config = {
              vertical = {
                prompt_position = "top";
                mirror = true;
              };
              horizontal = {
                prompt_position = "top";
                mirror = false;
              };
            };

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

            mappings = {
              i = {
                "<esc>".__raw = "require('telescope.actions').close";
                # Ctrl-v for vertical split
                "<C-v>".__raw = "require('telescope.actions').select_vertical";
                # Ctrl-x for horizontal split
                "<C-h>".__raw = "require('telescope.actions').select_horizontal";
              };
            };
          };

          pickers = {
            buffrs = {
              sort_lastused = true;
              sort_mru = true;
            };
            find_files = {
              find_command = [
                "fd"
                "--type"
                "f"
                "--strip-cwd-prefix"
                "--hidden"
                "--follow"
                "--exclude"
                ".git"
              ];
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

          "gd" = {
            action = "lsp_definitions";
            options.desc = "Go to definition";
          };

          "gr" = {
            action = "lsp_references";
            options.desc = "Go to references";
          };

          "gi" = {
            action = "lsp_implementations";
            options.desc = "Go to implementations";
          };

          "gt" = {
            action = "lsp_type_definitions";
            options.desc = "Go to type definitions";
          };
        };
      };
    };
  };
}
