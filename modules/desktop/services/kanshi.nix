{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop.services.kanshi;
in {
  options.modules.desktop.services.kanshi.enable = _mkBoolOpt false;

  config = mkIf cfg.enable {
    home._.services.kanshi = {
      enable = true;
      profiles.default.outputs = [
        {
          critera = "DP-2";
          mode = "1920x1080@144Hz";
          position = "0,0";
        }
      ];
      profiles.laptop.outputs = [
        {
          critera = "eDP-1";
          mode = "1920x1080@144Hz";
          position = "0,0";
        }
      ];
      profiles.art.outputs = [
        {
          critera = "DP-2";
          mode = "1920x1080x144Hz";
          position = "0,0";
        }
        {
          critera = "HDMI-A-1";
          mode = "2560x1440@60";
          position = "0,1080";
        }
      ];
    };
  };
}
