{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.fish;
in
{
  options.modules.fish.enable = mkEnableOption "fish";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.fish ];

    programs.fish = {
      enable = true;
    };
  };
}
