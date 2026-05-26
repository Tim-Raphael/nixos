{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    profiles.default = {
      search = {
        default = "ddg";
        force = true;
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
      ];
    };
  };
}
