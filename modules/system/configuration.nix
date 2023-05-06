{ config, inputs, pkgs, ... }:
{
  environment.defaultPackages = [ ];
  services.xserver.desktopManager.xterm.enable = false;

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    acpi tlp git neovim
  ];

  fonts = {
    fonts = with pkgs; [
      jetbrains-mono
      roboto
      openmoji-color
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "Iosevka" ]; })
    ];

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        emoji = [ "OpenMoji Color" ];
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
  nix = {
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "yuugen" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  boot = {
    initrd.kernelModules = [ "amdgpu" ];

    tmp.cleanOnBoot = true;
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;

        theme = pkgs.nixos-grub2-theme;
      };

      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 10;
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users.users.yuugen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "audio" "video" "networkmanager" ];
    shell = pkgs.fish;
  };

  networking = {
    wireless.iwd.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 443 80 ];
      allowedUDPPorts = [ 443 80 44857 ];
      allowPing = false;
    };
  };

  environment.variables = {
    EDITOR = "nvim";
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    GTK_RC_FILES = "$HOME/.config/gtk-1.0/gtk.css";
    GTK2_RC_FILES = "$HOME/.config/gtk-2.0/gtk.css";
    MOZ_ENABLE_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    ANKI_WAYLAND = "1";
    DISABLE_QT5_COMPAT = "0";
  };

  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "yuugen" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    protectKernelImage = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [ pkgs.amdvlk ];
    };
    nvidia = {
      modesetting.enable = true;
    };
  };

  system.stateVersion = "23.05";
}
