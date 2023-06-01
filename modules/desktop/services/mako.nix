{ config, lib, options, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop.services.mako;
  inherit (lib._) hexColor colors;
in {
  options.modules.desktop.services.mako.enable = true;

  config = mkIf cfg.enable {
    home._.programs.mako = {
      enable = true;
      anchor = "top-right";
      layer = "overlay";

      font = "SF Pro Display 11";

      backgroundColor = hexColor colors.gray._200;
      progressColor = "source ${hexColor colors.gray._300}";
      textColor = hexColor colors.gray._700;
      padding = "15,20";
      margin = "0,10,10,0";

      borderSize = 1;
      borderColor = hexColor colors.gray._300;
      borderRadius = 4;

      defaultTimeout = 5000;
      extraConfig = ''
        [urgency=high]
        ignore-timeout=1
        text-color=${hexColor colors.red._900}
        background-color=${hexColor colors.red._200}
        progress-color=${hexColor colors.red._300}
        border-color=${hexColor colors.red._300}
      '';
    };
  };
}
