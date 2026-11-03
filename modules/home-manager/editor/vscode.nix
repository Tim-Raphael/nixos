{
  lib,
  pkgs,
  config,
  ...
}:

with lib;
let
  cfg = config.editor.vscode;
  rustToolchain = pkgs.rust-bin.selectLatestNightlyWith (
    toolchain:
    toolchain.default.override {
      extensions = [
        "rust-analyzer"
        "rust-src"
        "rustfmt"
      ];
    }
  );
in
{
  options.editor.vscode.enable = mkEnableOption "VS Code";

  config = mkIf cfg.enable {
    stylix.targets.vscode.enable = false;

    home.packages = with pkgs; [
      biome
      buf
      clang-tools
      eslint
      gcc
      jdt-language-server
      lua-language-server
      ltex-ls-plus
      nixd
      nixfmt
      prettierd
      protols
      pyright
      rustToolchain
      shfmt
      tailwindcss-language-server
      taplo
      typos-lsp
      vtsls
      vscode-langservers-extracted
      yaml-language-server
      yamlfmt
    ];

    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscode;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          biomejs.biome
          bradlc.vscode-tailwindcss
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode
          jnoortheen.nix-ide
          llvm-vs-code-extensions.vscode-clangd
          ms-python.python
          redhat.java
          redhat.vscode-yaml
          rust-lang.rust-analyzer
          streetsidesoftware.code-spell-checker
          sumneko.lua
          tamasfe.even-better-toml
          valentjn.vscode-ltex
          vscodevim.vim
        ];

        userSettings = lib.mkDefault {
          "diffEditor.renderSideBySide" = true;
          "diffEditor.useInlineViewWhenSpaceIsLimited" = true;
          "editor.fontFamily" = config.stylix.fonts.monospace.name;
          "rust-analyzer.server.path" = "${rustToolchain}/bin/rust-analyzer";
          "workbench.activityBar.location" = "top";
          "workbench.editor.enablePreview" = false;
          "workbench.editor.enablePreviewFromQuickOpen" = false;
          "window.commandCenter" = false;
          "chat.titleBar.openInAgentsWindow.enabled" = false;
          "window.menuBarVisibility" = "compact";
          "workbench.browser.showInTitleBar" = false;
          "claudeCode.hideOnboarding" = true;
          "workbench.layoutControl.enabled" = false;
          "workbench.statusBar.visible" = false;
        };
      };
    };
  };
}
