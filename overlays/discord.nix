{ lib }:
(
  import (builtins.fetchTarball {
    url = "https://github.com/InternetUnexplorer/discord-overlay/archive/main.tar.gz";
    sha256 = "0wgm7sk9fca38a50hrsqwz6q79z35gqgb9nw80xz7pfdr4jy9pf8";
  })
)
