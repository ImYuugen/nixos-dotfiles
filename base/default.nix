{ ... }:
{
  # Call every brother files
  imports = [
    ./users.nix
    ./nix.nix
    ./programs
  ];
}
