{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    qutebrowser
  ];

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
