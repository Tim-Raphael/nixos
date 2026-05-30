{ pkgs, ... }:

{
  stylix.targets.firefox.profileNames = [ "main" ];
  programs.firefox = {
    enable = true;
    profiles.main = {
      search = {
        default = "ddg";
        force = true;
      };
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
        ];
      };
    };
  };
}
