{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.xdg;
in
{
  options.modules.xdg.enable = mkEnableOption "xdg";
  config = mkIf cfg.enable {
    xdg.userDirs = {
      enable = true;
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      publicShare = "$HOME/Public";
      videos = "$HOME/Videos";
    };
  };
}
