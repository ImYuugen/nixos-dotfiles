{ config, lib, pkgs, ... }:
{
  imports = [
      ./home.nix
      ./hardware-configuration.nix
  ];

  networking = {
    hostName = "Omen";
    useDHCP = false;
    networkmanager.enable = true;
    firewall = {
      allowedUDPPorts = [  ]; # Open ports here
    };
  };

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];

    loader = {
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
      };

      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  # Set your time zone.
  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true; # Avoid dual boot desync
  };

  # IME
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-mozc ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  sound.enable = false;
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    printing.enable = true;

    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = false;
    };

    geoclue2.enable = true;

    xserver = {
      videoDrivers = [ "amdgpu" "nvidia" ];
    };
  };

  hardware = {
    nvidia.modesetting.enable = true;
    opengl.enable = true;
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  programs = {
    light.enable = true;
  };

  virtualisation = {
    docker.enable = true;

    libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemu.package = pkgs.qemu_kvm;
    };
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      carlito
      dejavu_fonts
      fira-code
      fira-code-symbols
      iosevka
      ipafont                           #JP
      kochi-substitute                  #JP
      liberation_ttf
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      source-code-pro
      ttf_bitstream_vera
    ];

    #TODO: Font config
    fontconfig = {
      defaultFonts = {
        monospace = [
          "DejaVu Sans Mono"
          "IPAGothic"        #JP
        ];
        sansSerif = [
          "DejaVu Sans"
          "IPAPGothic"       #JP
        ];
        serif = [
          "DejaVu Serif"
          "IPAPMincho"       #JP
        ];
      };
    };
  };
}
