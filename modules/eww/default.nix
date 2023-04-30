{ config, inputs, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.eww;
  ewwPath = ".config/eww";
in
{
  options.modules.eww.enable = mkEnableOption "eww";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      eww-wayland
      alsa-utils
      brightnessctl
      # Fonts used by eww
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    home.file."${ewwPath}/eww.scss".source = ./eww.scss;
    home.file."${ewwPath}/eww.yuck".source = ./eww.yuck;

    home.file."${ewwPath}/scripts/battery.sh" = {
      source = ./scripts/battery.sh;
      executable = true;
    };
    home.file."${ewwPath}/scripts/brightness.sh" = {
      source = ./scripts/brightness.sh;
      executable = true;
    };
# Add other scripts idfk
  };
}
