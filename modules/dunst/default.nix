{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.dunst;
in
{
  options.modules.dunst.enable = mkEnableOption "dunst";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.dunst ];

    services.dunst = {
      enable = true;
      settings = {
        global = {
        # TODO: Add config
          timeout = 3;
        };
      };
    };
  };
}
