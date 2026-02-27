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
        profile.name = "home-docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "DP-5";
            status = "enable";
            mode = "3840x2160@120.000000";
            position = "0,0";
            scale = 1.0;
          }
        ];
      }

      {
        profile.name = "home";
        profile.outputs = [
          {
            criteria = "DP-3";
            status = "enable";
            mode = "3840x2160@120.000000Hz";
            position = "1920,0";
            scale = 1.0;
          }
        ];
      }

      {
        profile.name = "work";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "DP-2";
            status = "enable";
            mode = "2560x1440@59.951000Hz";
            position = "0,0";
            scale = 1.0;
          }
        ];
      }

      {
        profile.name = "hackathon";
        profile.outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
            mode = "2560x1440@59.951000Hz";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "eDP-1";
            status = "enable";
            position = "2560,0";
            scale = 1.0;
          }
        ];
      }
    ];
  };
}
