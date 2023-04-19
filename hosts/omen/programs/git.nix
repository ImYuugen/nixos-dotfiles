{ ... }:

{
  enable = true;
  userName = "Yuugen";
  userEmail = "yuugenssb@gmail.com";

  aliases = {
  };
  ignores = [ "*~" "*.swp" ".o" ".d" "format_marker" ]; # Global .gitignore

  extraConfig = {
    pull = {
      rebase = true;
    };
  };
}
