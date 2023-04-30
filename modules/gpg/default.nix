{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.gpg;
in
{
  options.modules.gpg.enable = mkEnableOption "gpg";
  config = mkIf cfg.enable {
    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "qt";
    };
  };
}
