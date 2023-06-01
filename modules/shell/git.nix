{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.shell.git;
in {
  options.modules.shell.git = {
    enable = _.mkBoolOpt false;
    userName = _.mkOpt' types.str "Yuugen";
    userEmail = _.mkOpt' types.str "yuugenssb@proton.me";
  };

  config = mkIf cfg.enable {
    home._.programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      signing.signByDefault = true;
      ignores = [
        "/target"
        "/.vscode"
        "/.lsp"
        ".nrepl-port"
        ".direnv"
        "/.clangd"
        "compile_commands.json"
      ];
      aliases = {
        last = "log -1 HEAD";
      };
      extraConfig = {
        color.ui = true;
        pull.rebase = true;
        url."git@github.com:".insteadOf = [ "https://github.com/" ];
        init.defaultBranch = "main";
      };
      delta.enable = true;
    };
  };
}
