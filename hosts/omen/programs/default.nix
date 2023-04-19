{ pkgs, ... }:

{
  home-manager.enable = true;  
  fish.enable = true;

  neovim = import ./neovim { inherit pkgs; } ;

  git = import ./git.nix {};

  alacritty = import ./alacritty.nix {};

  bash = import ./bash { inherit pkgs; };

  rofi = import ./rofi { inherit pkgs; };

  fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  ncmpcpp = import ./ncmpcpp.nix {};

  waybar.enable = true;

  #mako.enable = true;
}
