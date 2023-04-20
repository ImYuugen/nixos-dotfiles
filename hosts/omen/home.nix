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
        nodejs

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
        gcc gdb #C/C++
        luajit #Lua
        nil     #Nix
        rustup rust-analyzer  #Rust
        wasmer wasmtime  #WebAssembly

        #Media
	    ani-cli
        krita
        mpv
        obs-studio
	    spotify
        vlc
        yt-dlp

        #Network
        wireguard-tools

        #Utils
        alsa-utils
	    betterdiscordctl
        flameshot
        gnupg
        gtop
        jellyfin-ffmpeg
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
