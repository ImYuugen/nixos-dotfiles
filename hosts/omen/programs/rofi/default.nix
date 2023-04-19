{ pkgs, ... }:

{
  enable = true;

  package = pkgs.rofi.override {
    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
    ];
  };
}
