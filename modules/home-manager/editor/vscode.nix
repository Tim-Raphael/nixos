{
  lib,
  pkgs,
  config,
  ...
}:

with lib;
let
  cfg = config.editor.vscode;
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
      jdt-language-server
      lua-language-server
      ltex-ls-plus
      nixd
      nixfmt
      prettierd
      protols
      pyright
      rust-analyzer
      shfmt
      tailwindcss-language-server
      taplo
      typos-lsp
      vtsls
      vscode-langservers-extracted
      yaml-language-server
      yamlfmt
      (rust-bin.selectLatestNightlyWith (
        toolchain:
        toolchain.default.override {
          extensions = [ "rustfmt" ];
        }
      ))
    ];

    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscode;

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
        "diffEditor.renderSideBySide" = false;
        "workbench.activityBar.location" = "top";
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
}
