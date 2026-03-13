{
  lib,
  config,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.graphics.nvidia;
in
{
  options.graphics.nvidia = {
    enable = mkEnableOption "Enables nvidia GPU support";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
  };
}
