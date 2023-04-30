{ config, lib, inputs, ... }:
{
  imports = [ ../../modules ];
  config.modules = {
    firefox.enable = true;
    kitty.enable = true;
    eww.enable = true;
    dunst.enable = true;
    hyprland.enable = true;
    wofi.enable = true;

    nvim.enable = true;
    fish.enable = true;
    git.enable = true;
    gpg.enable = true;
    direnv.enable = true;

    xdg.enable = true;
    packages.enable = true;
  };
}
