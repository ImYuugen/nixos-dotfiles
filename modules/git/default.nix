{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.git;
in
{
  options.modules.git.enable = mkEnableOption "git";
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "yuugen";
      userEmail = "yuugenssb@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        core.excludesfile = "$NIXOS_CONFIG_DIR/gitignore";
      };
    };
  };
}
