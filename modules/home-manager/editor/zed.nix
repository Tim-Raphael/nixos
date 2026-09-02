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

    xdg.dataFile."fonts/${config.stylix.fonts.monospace.name}" = {
      source = "${config.stylix.fonts.monospace.package}/share/fonts";
      recursive = true;
    };

    programs.zed-editor = {
      enable = true;

      package = pkgs.unstable.zed-editor;

      mutableUserSettings = false;
      mutableUserKeymaps = false;

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
        vim_mode = true;
        relative_line_numbers = true;

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
      };
    };
  };
}
