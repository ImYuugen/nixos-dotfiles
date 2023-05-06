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
    ];

    programs.neovim.enable = true;

    # I prefer to use lua files for my neovim config
    home.file.".config/nvim/init.lua".source = ./config/init.lua;
	
    home.file.".config/nvim/lua/yuugen/init.lua".source = ./config/lua/yuugen/init.lua;
    home.file.".config/nvim/lua/yuugen/map.lua".source = ./config/lua/yuugen/map.lua;    
    home.file.".config/nvim/lua/yuugen/packer.lua".source = ./config/lua/yuugen/packer.lua;
    home.file.".config/nvim/lua/yuugen/set.lua".source = ./config/lua/yuugen/set.lua;

    home.file.".config/nvim/after/plugin/colors.lua".source = ./config/after/plugin/colors.lua;
    home.file.".config/nvim/after/plugin/lsp.lua".source = ./config/after/plugin/lsp.lua;
    home.file.".config/nvim/after/plugin/treesitter.lua".source = ./config/after/plugin/treesitter.lua;
  };
}
