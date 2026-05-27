{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.main = {
      search = {
        default = "ddg";
        force = true;
      };

      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
        ];
      };
    };
  };

  stylix.targets.firefox = {
    profileNames = [ "main" ];
    colorTheme.enable = true;
  };
}
