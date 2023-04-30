{
  description = "gnnnfggnfgngn..,,,...,";

  outputs = { home-manager, nixpkgs, nur, ... } @inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = nixpkgs.lib;
    user = "yuugen";

    mkSystem = pkgs: system: hostname:
      pkgs.lib.nixosSystem {
        inherit system;
        modules = [
          { networking.hostName = hostname; }
          # General configuration
          ./modules/system/configuration.nix

          # Hardware related configuration
          ./hosts/${hostname}/hardware-configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = { inherit inputs; };
              users.${user} = ./hosts/${hostname}/user.nix;
            };
            nixpkgs.overlays = [
              nur.overlay
              (import ./overlays)
            ];
            nixpkgs.config.allowUnfree = true;
          }
        ];
        specialArgs = { inherit inputs; };
      };
  in {
    nixosConfigurations = {
      # Da Laptop
      #                 Pkgs    Arch      Hostname
      omen15 = mkSystem nixpkgs "${system}" "omen15";
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };
  };
}
