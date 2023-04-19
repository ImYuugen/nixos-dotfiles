{ pkgs, ... }:
{
  programs = {
    command-not-found.enable = true;
    fish.enable = true;
  };

  # Global Packages
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
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
