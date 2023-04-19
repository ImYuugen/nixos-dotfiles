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
	

        #Desktop/Wayland
	cliphist
	eww-wayland
        grim
	hyprpicker
	hyprpaper
        libnotify
	polkit
	waybar
        wayland
        wdisplays
	wireplumber
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
	ani-cli
        krita
        obs-studio
	spotify
        vlc

        #Network
        wireguard-tools

        #Utils
	betterdiscordctl
        flameshot
        gnupg
        gtop
        neofetch
	playerctl
        ripgrep
	udiskie
        qpwgraph
	wev

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
