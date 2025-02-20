{ config, pkgs, ... }:

{
  # Disable pulseaudio, enable pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Uncomment for JACK support
    # jack.enable = true;
  };
}
