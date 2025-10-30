{ ... }:

{
  services.kanshi = {
    enable = true;

    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,0";
            scale = 1.0;
          }
        ];
      }

      {
        profile.name = "home_docked";
        profile.outputs = [
          {
            criteria = "DP-8";
            status = "enable";
            mode = "1920x1080@60.000Hz";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "DP-7";
            status = "enable";
            mode = "1920x1080@144.013Hz";
            position = "1920,0";
            scale = 1.0;
          }
        ];
      }

      {
        profile.name = "home";
        profile.outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
            mode = "1920x1080@74.973000Hz";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "DP-1";
            status = "enable";
            mode = "1920x1080@143.854996Hz";
            position = "1920,0";
            scale = 1.0;
          }
        ];
      }

      {
        profile.name = "work";
        profile.outputs = [
          {
            criteria = "DP-2";
            status = "enable";
            mode = "2560x1440@59.951000Hz";
            position = "0,0";
            scale = 1.0;
          }
        ];
      }
    ];
  };
}
