{ config, inputs, pkgs, ... }:
{
  home.stateVersion = "23.05";
  imports = [
    ./firefox
    ./kitty
    ./eww
    ./dunst
    ./hyprland
    ./wofi

    ./nvim
    ./fish
    ./git
    ./gpg
    ./direnv

    ./xdg
    ./packages
  ];
}
