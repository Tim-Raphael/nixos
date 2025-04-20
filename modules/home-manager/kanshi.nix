{
  pkgs,
  ...
}:

{
  services.kanshi = {
    enable = true;

    profiles = {
      home = {
        outputs = [
          {
            criteria = "DP-1";
            status = "enable";
            mode = "1920x1080@143.854996Hz";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "HDMI-A-1";
            status = "enable";
            mode = "1920x1080@74.973000Hz";
            position = "1920,0";
            scale = 1.0;
          }
        ];
      };
    };
  };
}
