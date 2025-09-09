{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
  ];

  programs.qutebrowser = {
    enable = true;

    keyBindings = {
      normal = {
        "<Ctrl-Shift-j>" = "tab-next";
        "<Ctrl-Shift-h>" = "tab-prev";
        "J" = "scroll-px 0 750";
        "K" = "scroll-px 0 -750";
      };
    };
  };

  programs.chromium = {
    enable = true;

    dictionaries = with pkgs; [
      hunspellDictsChromium.en_US
      hunspellDictsChromium.de_DE
    ];

    extensions = [
      # Darkreader
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }

      # Ublock Origin Lite
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; }

      # React Developer Tools
      { id = "fmkadmapgofadopljbjfkapdkoienihi"; }

      # LanguageTool
      { id = "oldceeleldhonbafppcapldpdifcinji"; }
    ];
  };
}
