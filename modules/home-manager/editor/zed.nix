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
    "vscode-css-language-server" = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
    "yaml-language-server" = "${pkgs.yaml-language-server}/bin/yaml-language-server";
    "tailwindcss-language-server" = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
    "bash-language-server" = "${pkgs.bash-language-server}/bin/bash-language-server";
    lua-language-server = "${pkgs.lua-language-server}/bin/lua-language-server";
    taplo = "${pkgs.taplo}/bin/taplo";
  };
in
{
  options.editor.zed.enable = mkEnableOption "Zed";

  config = mkIf cfg.enable {
    stylix.targets.zed.enable = false;

    programs.zed-editor = {
      enable = true;

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
        biome
        prettierd
        shfmt

        claude-agent-acp
        unstable.claude-code
      ];

      # Nvim-style keybindings (see modules/editor/nixvim). Requires vim
      # mode below so <space> works as the leader in normal mode. Bindings
      # are scoped to the editor's vim normal mode so they never clobber
      # typing; the insert-mode block only mirrors ctrl-backspace.
      userKeymaps = [
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            # Pickers (Telescope equivalents)
            "space f" = "file_finder::Toggle"; # Find Files
            "space shift-f" = "file_finder::Toggle"; # Find Files (all)
            "space g" = "pane::DeploySearch"; # Grep
            "space s" = "outline::Toggle"; # Symbol Search (document)
            "space shift-s" = "project_symbols::Toggle"; # Workspace Symbol Search
            "space b" = "tab_switcher::Toggle"; # Buffers
            "space p" = "projects::OpenRecent"; # Projects
            "space d" = "diagnostics::DeployCurrentFile"; # Document Diagnostics
            "space shift-d" = "diagnostics::Deploy"; # Diagnostics (all)

            # LSP navigation
            "g d" = "editor::GoToDefinition";
            "g r" = "editor::FindAllReferences";
            "g i" = "editor::GoToImplementation";
            "g t" = "editor::GoToTypeDefinition";
            "g j" = "editor::GoToDiagnostic"; # next diagnostic
            "g k" = "editor::GoToPreviousDiagnostic"; # prev diagnostic

            # LSP actions
            "space r" = "editor::Rename";
            "space a" = "editor::ToggleCodeActions";
            "t h" = "editor::ToggleInlayHints";

            # Git menu (<leader>v...)
            "space v d" = "git::Diff"; # diff
            "space v shift-d" = "git::Diff"; # diff
            "space v shift-s" = "git::StageFile"; # stage file
            "space v s" = "git::StageAndNext"; # stage hunk
            "space v u" = "git::UnstageAndNext"; # unstage hunk
            "space v v" = "git_panel::ToggleFocus"; # toggle git view
            "space v p" = "git::Push";
            "space v shift-p" = "git::Pull";
            "space v c" = "git::Commit";
            "space v b" = "editor::ToggleGitBlame";

            # Window navigation (ctrl-h/j/k/l)
            "ctrl-h" = "workspace::ActivatePaneLeft";
            "ctrl-j" = "workspace::ActivatePaneDown";
            "ctrl-k" = "workspace::ActivatePaneUp";
            "ctrl-l" = "workspace::ActivatePaneRight";

            # Tabs
            "ctrl-t" = "workspace::NewFile"; # new tab
            "ctrl-shift-l" = "pane::ActivateNextItem"; # next tab
            "ctrl-shift-h" = "pane::ActivatePreviousItem"; # prev tab

            # File explorer (oil equivalent)
            "ctrl-n" = "project_panel::ToggleFocus";
          };
        }
        {
          context = "Editor && vim_mode == insert";
          bindings = {
            "ctrl-backspace" = "editor::DeleteToPreviousWordStart";
          };
        }
      ];

      userSettings = {
        # Modal editing to match the nixvim setup and enable <space> leader.
        vim_mode = true;

        # Match the relative line numbers used in the VS Code setup.
        relative_line_numbers = true;

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

        lsp = mapAttrs (_: path: { binary = { inherit path; }; }) languageServers;

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

        format_on_save = "on";
      };
    };
  };
}
