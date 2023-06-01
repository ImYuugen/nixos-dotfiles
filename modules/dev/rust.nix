{ config, lib, options, pkgs, ... }:

with lib;
let
  cfg = config.modules.dev.rust;
in {
  options.modules.dev.rust.enable = _.mkBoolOpt false;

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      cargo
      rustc
      rust-analyzer
      rustfmt

      # Necessary for the openssl-sys crate
      openssl
      pkg-config
    ];
  };
}
