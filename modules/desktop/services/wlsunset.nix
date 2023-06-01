{ config, lib, options, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop.services.wlsunset;
in {
  options.modules.desktop.services.wlsunset = {
    enable = _.mkBoolOpt false;
    latitude = _.mkOpt' types.str "48.8";
    longitude = _.mkOpt' types.str "2.3";
    temperature.night = _.mkOpt' types.int 6500;
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name}.services.wlsunset = {
      enable = true;
      latitude = cfg.latitude;
      longitude = cfg.longitude;
      temperature.night = cfg.temperature.night;
    };
  };
}
