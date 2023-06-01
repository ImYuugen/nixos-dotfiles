#
# IT'S THE FIFTH FUCKING TIME I REWRITE
# THIS FILE, I SURE DO HOPE IT WORKS
#

{
  description = "gnnnfggnfgngn..,,,..,.";

  outputs = { self, nixpkgs, ... } @inputs:
    let
      system = "x86_64-linux";

      lib = import ./lib { inherit pkgs inputs; lib = nixpkgs.lib; };

      mkPkgs = pkgs: overlays: import pkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = overlays ++ (lib.attrValues self.overlays);
      };

      pkgs = mkPkgs nixpkgs [ self.overlay ];

      inherit (lib._) mapModules mapModulesRec mkHost;
    in {
      packages."${system}" = mapModules ./packages (p: pkgs.callPackage p {});

      overlay = final: prev: {
        _ = self.packages."${system}";
      };

      overlays = mapModules ./overlays import;

      nixosModules = mapModulesRec ./modules import;

      nixosConfigurations = mapModules ./hosts (mkHost system);

      devShell."${system}" =
        import ./shell.nix { inherit pkgs; };
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

    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    #hyprland = {
    #  url = "github:hyprwm/Hyprland";
    #};
  };
}
