{ config, lib, pkgs, ... }:

{
  home-manager.users.yuugen = {
    home = {
      username = "yuugen";
      homeDirectory = "/home/yuugen";

      # Here comes the stuff
      packages = builtins.attrValues {
        inherit(pkgs)

        #Apps
        alacritty
        evince
        firefox

        #Dev
        #neovim

        #Desktop/Wayland
        grim
        libnotify
        wayland
        wdisplays
        wofi
        xdg-desktop-portal
        xdg-desktop-portal-wlr

        #Files
        lz4 unrar unzip zip

        #Langs
        gcc     #C/CPP
        nil     #Nix
        rustup  #Rust

        #Media
        krita
        obs-studio
        vlc

        #Network
        wireguard-tools

        #Utils
        flameshot
        gnupg
        gtop
        neofetch
        ripgrep
        qpwgraph

        #Custom defined programs
        discord
        ;
        inherit(pkgs.texlive.combined)
        scheme-full
        ;
      };
    };

    programs = import ./programs { inherit pkgs; };

    services = import ./services { inherit pkgs; };
  };
}
