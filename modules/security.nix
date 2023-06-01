{ config, lib, ... }:

{
  boot = {
    tmpOnTmpfs = lib.mkDefault true;
    boot.cleanTmpDir = lib.mkDefault (!config.boot.tmpOnTmpfs);
    loader.systemd-boot.editor = false;
  };

  security.doas.enable = true;
  security.sudo.enable = false;
  environment.shellAliases = {
    sudo = "doas";
  };
}
