{ pkgs, lib, config, ... }:

with lib;
let cfg =
    config.modules.packages;
    screen = pkgs.writeShellScriptBin "screen" ''${builtins.readFile ./screen}'';
    bandw = pkgs.writeShellScriptBin "bandw" ''${builtins.readFile ./bandw}'';
    maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';
    nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''${builtins.readFile ./nvidia-offload}'';
in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
    	home.packages = with pkgs; [
            ripgrep ffmpeg tealdeer
            exa htop fzf
            pass gnupg bat
            unzip lowdown zk
            grim slurp slop
            imagemagick age libnotify
            git python3 lua zig
            mpv firefox pqiv
            screen bandw maintenance nvidia-offload
            wf-recorder anki-bin
            discord spotify
        ];
    };
}
