# TODO: this should be part of users.nix
{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.remoteUser;
in
{
  options.remoteUser = {
    enable = mkEnableOption "remote user account with SSH access";
    username = mkOption {
      type = types.str;
      default = "remote";
      description = "Username for the remote user";
    };
    authorizedKeys = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "SSH public keys authorized for the remote user";
      example = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAxTlPKWtC6DN8Ii81peVUT4SyKvWGO7smSgK/UCjUO remote"
      ];
    };
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;

    users.users.${cfg.username} = {
      isNormalUser = true;
      description = "Remote access user";
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = cfg.authorizedKeys;
    };

    services.openssh.settings.AllowUsers = [
      "raphael"
      cfg.username
    ];
  };
}
