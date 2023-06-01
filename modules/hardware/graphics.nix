{ config, lib, options, pkgs, ... }:

with lib;
let
  cfg = config.modules.hardware.graphics;
in {
  options.modules.hardware.graphics = {
    enable = _.mkBoolOpt false;
    vaapi = {
      enable = _.mkBoolOpt false;
      package = _.mkOpt types.package pkgs.nvidia-vaapi-driver "Package to use for VAAPI";
    };
  };

  config = mkIf cfg.enable {
    hardware.opengl.enable = true;
    hardware.opengl.extraPackages = mkIf cfg.vaapi.enable [
      cfg.vaapi.package
    ];
  };
}
