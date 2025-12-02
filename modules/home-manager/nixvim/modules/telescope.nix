{ ... }:

{
  programs.nixvim = {
    dependencies.ripgrep.enable = true;
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
            layout_strategy = "horizontal";
            # Sort results from top to bottom
            sorting_strategy = "ascending";
            preview_cutoff = 1;
            layout_config = {
              preview_cutoff = 1;
              horizontal = {
                prompt_position = "top";
              };
            };
            results_title = false;
            disable_devicons = true;
            # Remove borders entirely for no padding between elements
            borderchars = {
              prompt = [
                "─"
                "│"
                "─"
                "│"
                "┌"
                "┐"
                "┘"
                "└"
              ];
              results = [
                "─"
                "│"
                "─"
                "│"
                "┌"
                "┐"
                "┘"
                "└"
              ];
              preview = [
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
