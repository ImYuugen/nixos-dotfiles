{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.nvim;
in
{
  options.modules.nvim.enable = mkEnableOption "nvim";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rnix-lsp nixfmt # Nix
      sumneko-lua-language-server stylua # Lua
      rust-analyzer # Rust
      bash-language-server # Bash
    ];

    programs.fish = {
      initExtra = ''
        export EDITOR="nvim"
      '';
    };

    programs.neovim.enable = true;

    # I prefer to use lua files for my neovim config
    home.file.".config/nvim/".source = ./config/;
  };
}
