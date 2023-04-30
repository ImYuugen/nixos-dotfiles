{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.kitty;
in
{
  options.modules.kitty.enable = mkEnableOption "kitty";
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
    };
  };
}
