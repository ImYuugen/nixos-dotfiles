{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop.swaywm;
  audioSupport = config.modules.hardware.audio.enable;
  import-gsettings = _.buildBinScript "import-gsettings";
in {
  options.modules.desktop.swaywm = {
    enable = _.mkBoolOpt false;
    term = _.mkOpt types.str "foot" "Default terminal to run";
    menu = _.mkOpt types.str "nwggrid" "Default menu to launch apps";
    wallpaper = _.mkOpt' (types.either types.str types.path) "";
    lockWallpaper = _.mkOpt' (types.either types.str types.path) "";
  };

  config = mkIf cfg.enable {
    programs.sway = {
      enable = true;
      extraPackages = with pkgs; [ xwayland gsettings_desktop_schemas ];
    };

    user.packages = with pkgs; mkMerge [
      [ swaybg autotiling glib import-gsettings ]
      [ grim slurp wl-clipboard libnotify light ]
      ( mkIf audioSupport [ pulseaudio playerctl ] )
    ];

    programs.light.enable = true;
    user.extraGroups = [ "video" ];

    modules.desktop.apps.term.${cfg.term}.enable = true;
    modules.desktop.apps.menu.${cfg.menu}.enable = true;
    modules.desktop.utils.swaylock.enable = true;

    modules.desktop.services.kanshi.enable = true;
    modules.desktop.services.mako.enable = true;
    modules.desktop.services.swayidle.enable = true;
    modules.desktop.services.waybar.enable = true;

    xdg.portal.enable = true;

    home._.wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config = {
        #assigns = let
        #  assign = n: id: { "${toString n}" = [id]; };
        #in {/* assign <a key> { class = "an app" } // ... // ... */};

        bars = [ { command = "waybar"; } ];
        fonts = {
          names = [ "Font Awesome 5 Free" "SF Pro Display" ];
          size = 11.0;
        };
        gaps.inner = 20;

        input."type:keyboard" = {
          xkb_layout = "us,fr";
          xkb_variant = "";
          xkb_options = "";
          xkb_numlock = "enabled";
        };
        input."type.touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_method = "two_finger";
        };

        keybindings = let
          mod = config.home._.wayland.windowManager.sway.config.modifier;
          processScreenshot = ''wl-copy -t image/png && notify-send "Screenshot taken"'';
        in lib.mkOptionDefault {
          "Mod1+l" = "exec lock";
          # Control volume
          XF86AudioRaiseVolume = mkIf audioSupport "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
          XF86AudioLowerVolume = mkIf audioSupport "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
          XF86AudioMute = mkIf audioSupport "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          XF86AudioMicMute = mkIf audioSupport "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          # Control media
          XF86AudioPlay = mkIf audioSupport "exec playerctl play-pause";
          XF86AudioPause = mkIf audioSupport "exec playerctl play-pause";
          XF86AudioNext = mkIf audioSupport "exec playerctl next";
          XF86AudioPrev = mkIf audioSupport "exec playerctl previous";
          # Control brightness
          XF86MonBrightnessUp = "exec light -A 10";
          XF86MonBrightnessDown = "exec light -U 10";
          # Screenshot
          "${mod}+Print" = ''exec grim - | ${processScreenshot}'';
          "${mod}+Shift+Print" = ''exec grim -g "$(slurp -d)" - | ${processScreenshot}'';
          # Workspace 10
          "${mod}+0" = "workspace 10";
          "${mod}+Shift+0" = "move container to workspace 10";
          # Shortcuts for easier navigation between workspaces
          "${mod}+Control+Left" = "workspace prev";
          "${mod}+Control+l" = "workspace prev";
          "${mod}+Control+Right" = "workspace next";
          "${mod}+Control+h" = "workspace next";
          "${mod}+Tab" = "workspace back_and_forth";

          # Exit sway
          "${mod}+Shift+e" = "exec nwgbar -o 0.2";
        };

        menu = config.modules.desktop.apps.menu.${cfg.menu}.executable;
        modifier = "Mod4";
        output."*" = { bg = "${cfg.wallpaper} fill"; };
        startup = [
          { command = "lock"; }
          { command = "autotiling"; }
          { command = "import-gsettings"; always = true; }
          { command = "mako"; }
        ];
        terminal = config.modules.desktop.apps.term.${cfg.term}.executable;
        window.border = 0;
        window.commands = let
          rule = command: criteria: { inherit command criteria; };
          floatingNoBorder = criteria: rule "floating enable, border none" criteria;
        in [
          (rule "floating enable, sticky enable, resize set 384 216, move position 1516 821" { app_id = "firefox"; title = "^Picture-in-Picture$"; })
          (rule "floating enable, resize set 1000 600" { app_id = "zoom"; title = "^(?!Zoom Meeting$)"; })
          (floatingNoBorder { app_id = "ulauncher"; })
        ];
      };
      extraConfig = ''
        seat seat0 xcursor_theme "${config.modules.desktop.gtk.cursorTheme.name}" ${toString config.modules.desktop.gtk.cursorTheme.size}
      '';
      extraSessionCommands = ''
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=sway
        export XDG_CURRENT_DESKTOP=sway
      '';
    };
  };
}
