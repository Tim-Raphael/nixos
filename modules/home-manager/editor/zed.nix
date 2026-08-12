{
  lib,
  pkgs,
  config,
  ...
}:

with lib;
let
  cfg = config.editor.zed;

  # Zed downloads these servers itself by default, but the prebuilt
  # binaries assume an FHS layout and fail to start on NixOS. Pin ours
  # by absolute path so Zed spawns a linker-correct binary instead.
  languageServers = {
    rust-analyzer = "${pkgs.rust-analyzer}/bin/rust-analyzer";
    nixd = "${pkgs.nixd}/bin/nixd";
    clangd = "${pkgs.clang-tools}/bin/clangd";
    pyright = "${pkgs.pyright}/bin/pyright-langserver";
    vtsls = "${pkgs.vtsls}/bin/vtsls";
    eslint = "${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server";
    "vscode-css-language-server" =
      "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
    "yaml-language-server" = "${pkgs.yaml-language-server}/bin/yaml-language-server";
    "tailwindcss-language-server" =
      "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
    "bash-language-server" = "${pkgs.bash-language-server}/bin/bash-language-server";
    lua-language-server = "${pkgs.lua-language-server}/bin/lua-language-server";
    taplo = "${pkgs.taplo}/bin/taplo";
  };

  # Once we pin binary.path, Zed stops passing the adapter's default
  # arguments, so the vscode-style servers lose the transport flag they
  # need and refuse to start. Restore the flags here. rust-analyzer,
  # nixd, clangd and lua-language-server default to stdio and need none.
  serverArguments = {
    pyright = [ "--stdio" ];
    vtsls = [ "--stdio" ];
    eslint = [ "--stdio" ];
    "vscode-css-language-server" = [ "--stdio" ];
    "yaml-language-server" = [ "--stdio" ];
    "tailwindcss-language-server" = [ "--stdio" ];
    "bash-language-server" = [ "start" ];
    taplo = [
      "lsp"
      "stdio"
    ];
  };
in
{
  options.editor.zed.enable = mkEnableOption "Zed";

  config = mkIf cfg.enable {
    stylix.targets.zed.enable = true;

    # Zed's Linux font loader (fontdb, via cosmic-text) doesn't read
    # fontconfig or the ~/.nix-profile/share/fonts dir that stylix installs
    # into — it only scans ~/.local/share/fonts and a couple of /usr dirs.
    # Without this it can't resolve `buffer_font_family` and silently falls
    # back to its bundled Zed Plex Mono, which ships ligatures. Mirror the
    # stylix monospace family into an XDG font dir Zed actually scans.
    xdg.dataFile."fonts/${config.stylix.fonts.monospace.name}" = {
      source = "${config.stylix.fonts.monospace.package}/share/fonts";
      recursive = true;
    };

    programs.zed-editor = {
      enable = true;

      # Zed's text finder search popup needs 1.9.0+, but stable nixpkgs
      # ships 1.3.6, so pull the editor from the unstable input.
      package = pkgs.unstable.zed-editor;

      # Write settings.json as an immutable store symlink instead of merging
      # into a mutable file on activation. Zed rewrites the file on onboarding
      # and UI edits, which silently drops our declared keys until the next
      # rebuild; the symlink keeps this config authoritative at all times.
      mutableUserSettings = false;

      # Keep keymap.json authoritative for the same reason as settings.
      mutableUserKeymaps = false;

      # Mirror the nixvim keymaps so the same vim muscle memory works in
      # Zed. Leader is space, matching mapleader in the nixvim globals.
      userKeymaps = [
        {
          context = "vim_mode == normal";
          bindings = {
            # Pickers. space g opens the text finder popup instead of a
            # results tab, which is why we run Zed from unstable. Use
            # text_finder::Toggle, the workspace-level action, because
            # project_search::OpenTextFinder only fires once a search is open.
            "space f" = "file_finder::Toggle";
            "space g" = "text_finder::Toggle";
            "space s" = "outline::Toggle";
            "space S" = "project_symbols::Toggle";
            "space b" = "tab_switcher::Toggle";
            "space p" = "projects::OpenRecent";
            "space P" = "projects::OpenRemote";
            "space w" = "git::Worktree";
            "space d" = "diagnostics::Deploy";
            "space D" = "diagnostics::Deploy";

            # Opens and focuses the terminal. Space cannot close it from
            # inside the terminal since space is shell input there, so use
            # the default ctrl-backtick to toggle it closed from within.
            "space t" = "terminal_panel::Toggle";

            # Toggle the agent panel running Claude Code over the ACP bridge,
            # and toggle the workspace sidebar listing projects and threads.
            # The sidebar's own thread actions only fire while it holds focus,
            # so use the Workspace-level toggle, which dispatches from here.
            "space c" = "agent::Toggle";
            "space C" = "multi_workspace::ToggleWorkspaceSidebar";

            # LSP actions.
            "space r" = "editor::Rename";
            "space a" = "editor::ToggleCodeActions";
            "t h" = "editor::ToggleInlayHints";

            # Zed's vim layer already binds these g keys to other things
            # (g i inserts, g t jumps to the window top, g j and g k move
            # by line), so we rebind them to the nixvim LSP navigation.
            "g d" = "editor::GoToDefinition";
            "g r" = "editor::FindAllReferences";
            "g i" = "editor::GoToImplementation";
            "g t" = "editor::GoToTypeDefinition";
            "g j" = "editor::GoToDiagnostic";
            "g k" = "editor::GoToPreviousDiagnostic";

            # Git, mapped to the fugitive and gitsigns equivalents.
            "space V" = "git_panel::Toggle";
            "space v s" = "git::StageAndNext";
            "space v u" = "git::UnstageAndNext";
            "space v S" = "git::StageFile";
            "space v c" = "git::Commit";
            "space v p" = "git::Push";
            "space v P" = "git::Pull";
            "space v d" = "git::Diff";
            "space v b" = "git::Blame";

            # Window and tab navigation.
            "ctrl-h" = "workspace::ActivatePaneLeft";
            "ctrl-j" = "workspace::ActivatePaneDown";
            "ctrl-k" = "workspace::ActivatePaneUp";
            "ctrl-l" = "workspace::ActivatePaneRight";
            "ctrl-t" = "workspace::NewFile";
            "ctrl-shift-l" = "pane::ActivateNextItem";
            "ctrl-shift-h" = "pane::ActivatePreviousItem";

            # File tree, standing in for the oil parent-directory view.
            "ctrl-n" = "project_panel::Toggle";
          };
        }
        {
          # Match keymaps.nix, ctrl-backspace deletes the previous word.
          context = "vim_mode == insert";
          bindings = {
            "ctrl-backspace" = "editor::DeleteToPreviousWordStart";
          };
        }
        {
          # The leader pickers above only match when an editor is focused,
          # so they are dead on the empty start pane. Rebind the openers in
          # the context Zed itself uses for leader keys outside an editor,
          # which keeps them out of insert mode where space must type.
          context = "!Editor && !Terminal";
          bindings = {
            "space f" = "file_finder::Toggle";
            "space g" = "text_finder::Toggle";
            "space p" = "projects::OpenRecent";
            "space P" = "projects::OpenRemote";
            "space w" = "git::Worktree";
            "space b" = "tab_switcher::Toggle";
            "space S" = "project_symbols::Toggle";
            "space d" = "diagnostics::Deploy";
            "space D" = "diagnostics::Deploy";
            "space t" = "terminal_panel::Toggle";
            "space c" = "agent::Toggle";
            "space C" = "multi_workspace::ToggleWorkspaceSidebar";
          };
        }
        {
          # Scroll pickers like the file finder with the same j/k motions
          # used to move by line. This matches when the picker list itself
          # holds focus, not its query input.
          context = "Picker || menu";
          bindings = {
            "ctrl-j" = "menu::SelectNext";
            "ctrl-k" = "menu::SelectPrevious";
          };
        }
        {
          # While typing in a picker, focus is on the query editor, and the
          # default up/down bindings under this same context outrank the
          # Picker match above. Rebind here so ctrl-j/ctrl-k still scroll the
          # results of the file finder and the text finder (grep) mid-search.
          context = "Picker > Editor";
          bindings = {
            "ctrl-j" = "menu::SelectNext";
            "ctrl-k" = "menu::SelectPrevious";
          };
        }
        {
          # The code-action and completion popups are an editor context
          # menu rather than a picker, so they need their own actions. This
          # context outranks vim_mode == normal while the menu is open.
          context = "Editor && (showing_code_actions || showing_completions)";
          bindings = {
            "ctrl-j" = "editor::ContextMenuNext";
            "ctrl-k" = "editor::ContextMenuPrevious";
          };
        }
      ];

      # Grammars and server wiring for languages Zed lacks in core.
      extensions = [
        "nix"
        "toml"
        "lua"
        "html"
        "dockerfile"
      ];

      # Formatters are called by name, and the Claude Code bridge shells
      # out to `claude`, so both need to be on Zed's PATH.
      extraPackages = with pkgs; [
        rust-analyzer
        nixd
        clang-tools
        pyright
        vtsls
        vscode-langservers-extracted
        yaml-language-server
        tailwindcss-language-server
        bash-language-server
        lua-language-server
        taplo

        nixfmt
        #biome
        prettierd
        shfmt

        claude-agent-acp
        unstable.claude-code
      ];

      userSettings = {
        # Modal editing to match the nixvim setup.
        vim_mode = true;

        # Match the relative line numbers used in the VS Code setup.
        relative_line_numbers = true;

        # Preview tabs (on by default). Open file-finder picks as a preview
        # tab so single results don't pile up, and live-preview project
        # search results as you move through them in the multibuffer.
        preview_tabs = {
          enable_preview_from_file_finder = true;
          enable_preview_multibuffer_from_code_navigation = true;
        };

        # Disable programming ligatures.
        buffer_font_features = {
          calt = false;
          liga = false;
        };

        # Enlarge the agent panel text. Responses otherwise inherit the
        # stylix UI size (16) and user messages fall back to Zed's default
        # of 12, so set both so the whole conversation reads bigger.
        agent_ui_font_size = 18;
        agent_buffer_font_size = 18;

        # GitHub Copilot inline suggestions. Sign in via the command
        # palette ("copilot: sign in") on first launch.
        features = {
          edit_prediction_provider = "copilot";
        };

        # Drive Claude Code from the agent panel through the ACP bridge so
        # it reuses the CLI's existing subscription auth, no API key needed.
        agent_servers = {
          "Claude Code" = {
            command = "${pkgs.claude-agent-acp}/bin/claude-agent-acp";
            args = [ ];
            env = { };
          };
        };

        lsp = mapAttrs (name: path: {
          binary = {
            inherit path;
          }
          // optionalAttrs (serverArguments ? ${name}) {
            arguments = serverArguments.${name};
          };
        }) languageServers;

        languages = {
          Nix = {
            language_servers = [
              "nixd"
              "!nil"
            ];
            formatter = {
              external = {
                command = "nixfmt";
                arguments = [ "-" ];
              };
            };
          };
        };

        title_bar = {
          show_onboarding_banner = false;
          show_project_items = false;
          show_branch_name = false;
          show_user_menu = false;
        };

        tab_bar = {
          show = false;
        };

        toolbar = {
          quick_actions = false;
        };

        status_bar = {
          # Zed spells this key with a literal dot, so quote it to keep it
          # one key instead of a nested experimental.show attrset.
          "experimental.show" = false;
        };

        project_panel = {
          dock = "right";
          default_width = 400;
          hide_root = true;
          auto_fold_dirs = false;
          starts_open = false;
          git_status = false;
          sticky_scroll = false;
          scrollbar = {
            show = "never";
          };
          indent_guides = {
            show = "never";
          };
        };

        outline_panel = {
          default_width = 300;
          indent_guides = {
            show = "never";
          };
        };

        terminal = {
          # Dock the terminal to the right so it opens vertically beside the
          # code instead of splitting the bottom.
          dock = "right";
        };

        file_finder = {
          modal_max_width = "large";
        };

        scrollbar = {
          show = "never";
        };

        gutter = {
          min_line_number_digits = 0;
          folds = false;
          runnables = false;
        };

        indent_guides = {
          enabled = false;
        };

        multi_cursor_modifier = "cmd_or_ctrl";
        cursor_blink = false;
        drag_and_drop_selection = {
          enabled = false;
        };
        seed_search_query_from_cursor = "never";
        current_line_highlight = "none";
        show_whitespaces = "none";
        tab_size = 4;

        # Show diagnostics in the hover popover above the code. This is Zed's
        # only diagnostic popup, so it also brings back type and doc info on
        # hover; there is no diagnostics-only toggle. The red underline under
        # the diagnostic span is the default theme decoration, always on.
        hover_popover_enabled = true;

        auto_update = false;
        extend_comment_on_newline = false;
        horizontal_scroll_margin = 1;
        vertical_scroll_margin = 1;
        when_closing_with_no_tabs = "keep_window_open";
        close_on_file_delete = true;
        restore_on_file_reopen = false;
        restore_on_startup = "empty_tab";
        session = {
          restore_unsaved_buffers = false;
        };

        git = {
          git_gutter = "hide";
          inline_blame = {
            enabled = false;
          };
        };

        centered_layout = {
          right_padding = 0.15;
          left_padding = 0.15;
        };
      };
    };
  };
}
