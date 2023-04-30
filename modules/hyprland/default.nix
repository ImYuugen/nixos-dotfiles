{ config, inputs, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.hyprland;
in
{
  options.modules.hyprland.enable = mkEnableOption "hyprland";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprland
      swaybg
      wl-clipboard
      wlsunset
      wofi
    ];

    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  };
}
