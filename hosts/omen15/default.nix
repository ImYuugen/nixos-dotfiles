{ inputs, lib, pkgs, ... }:

let
  inherit (lib._) enable;
in {
  nix = {
    binaryCaches = [
      "https://hydra.iohk.io"
      "https://iohk.cachix.org"
    ];
    binaryCachePublicKeys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.omen-en00015p
  ];

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      font-awesome
      twitter-color-emoji
      _.otf-apple
      _.sf-mono-nerd-font
    ];
    fontconfig.enable = true;
    fontconfig.defaultFonts = {
      emoji = [ "Font Awesome 5 Free" "Noto Color Emoji" ];
      monospace = [ "SFMono Nerd Font" "SF Mono" ];
      serif = [ "New York Medium" ];
      sansSerif = [ "SF Pro Text" ];
    };
  };

  services.getty.autologinUser = "yuugen";

  time.timeZone = "Europe/Paris";

  environment.systemPackages = [ pkgs.efibootmgr ];

  user.packages = with pkgs; [
    # Dev
    httpie wrk heroku exercism jq shellcheck

    # Media
    spotify transmission-gtk imv ani-cli

    # Utils
    ripgrep bat exa tree killall unzip fd tokei procs
  ];

  modules = {
    shell = {
      git = enable;
      gpg = enable;
      neovim = {
        enable = true;
        lsp.servers = [
          "clangd"
          "rnix"
          "rust_analyzer"
          "lua_ls"
        ];
      };
      ssh = enable;
      zsh = enable;
    };
    desktop = {
      gtk.enable = true;
      games.enable = true;
      swaywm = {
        enable = true;
        term = "alacritty";
        wallpaper = ./assets/bg.jpg;
        lockWallpaper = ./assets/lock.jpg;
      };
      services = {
        wlsunset = enable;
      };
      apps = {
        firefox = enable;
        mpv = enable;
        zathura = enable;
      };
    };
    dev = {
      direnv = enable;
      c = enable;
      nix = enable;
      rust = enable;
    };
    hardware = {
      audio = {
        enable = true;
        pulseeffects.enable = false;
      };
      bluetooth = enable;
      graphics = {
        enable = true;
        vaapi.enable = true;
      };
    };
    services = {
      networkmanager = enable;
      postgresql.enable = true;
    };
  };

  services = {
    printing = enable;
    tlp = enable;
    udisks2 = enable;
    fprintd = enable;
  };
}
