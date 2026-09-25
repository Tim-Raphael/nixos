{
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.users;
in
{

  options = {
    users = {
      raphael.enable = mkOption {
        type = lib.types.bool;
        default = true;
        example = false;
        description = "Use default raphael user";
      };
      remote = {
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
            # Work
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINJI8PUBN58NGVjS+rGLber2B0CBSAFA96DsfHGxv+WD raphael"
          ];
        };
      };
    };
  };

  config = lib.mkMerge [
    (mkIf cfg.raphael.enable {
      users.users.raphael = {
        isNormalUser = true;
        description = "raphael";
        extraGroups = [
          "wheel"
          "networkmanager"
          "vboxusers"
          "kvm"
          "adbusers"
          "docker"
          "podman"
          "input"
          "wireshark"
          "uinput"
        ];
      };
    })

    (mkIf cfg.remote.enable {
      users.users.${cfg.remote.username} = {
        isNormalUser = true;
        description = "Remote access user";
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = cfg.remote.authorizedKeys;
      };
      services.openssh.settings.AllowUsers = [
        "raphael"
        cfg.remote.username
      ];
    })
  ];
}
