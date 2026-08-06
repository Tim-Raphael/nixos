{
  lib,
  pkgs,
  config,
  ...
}:

with lib;
let
  cfg = config.editor.vscode;
  baseFont = 12;
in
{
  options.editor.vscode.enable = mkEnableOption "VS Code with GitHub Copilot";

  config = mkIf cfg.enable {
    stylix.targets.vscode.enable = false;

    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
      profiles.default = {
        extensions = with pkgs.unstable.vscode-extensions; [
          anthropic.claude-code
          github.copilot-chat
          jnoortheen.nix-ide
          rust-lang.rust-analyzer
          llvm-vs-code-extensions.vscode-clangd
          dbaeumer.vscode-eslint
          sumneko.lua
          ms-pyright.pyright
          bradlc.vscode-tailwindcss
          redhat.vscode-yaml
          redhat.java
        ];
        userSettings = {
          "editor.lineNumbers" = "relative";
          "window.zoomLevel" = 2.5;
          "editor.fontSize" = lib.mkForce baseFont;
          "debug.console.fontSize" = lib.mkForce baseFont;
          "markdown.preview.fontSize" = lib.mkForce baseFont;
          "terminal.integrated.fontSize" = lib.mkForce baseFont;
          "chat.editor.fontSize" = lib.mkForce baseFont;
          "editor.minimap.sectionHeaderFontSize" = lib.mkForce (baseFont * 9.0 / 14.0);
          "scm.inputFontSize" = lib.mkForce (baseFont * 13.0 / 14.0);
          "screencastMode.fontSize" = lib.mkForce (baseFont * 56.0 / 14.0);
          "workbench.statusBar.visible" = false;
          "window.menuBarVisibility" = "compact";
          "window.commandCenter" = false;
          "workbench.navigationControl.enabled" = false;
          "workbench.layoutControl.enabled" = false;
          "workbench.browser.showInTitleBar" = false;
        };
      };
    };
  };
}
