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
