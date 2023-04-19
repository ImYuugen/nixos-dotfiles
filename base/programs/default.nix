{ pkgs, ... }:
{
  programs = {
    fish.enable = true;
  };

  # Global Packages
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
    brightnessctl
    file
    git
    git-lfs
    gnumake
    htop
    most
    neofetch
    pciutils
    python3
    tree
    wget
    ;
  };
}
