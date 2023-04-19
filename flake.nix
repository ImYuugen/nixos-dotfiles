{
  description = "Yuugen's NixOS Configuration";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOs";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      type = "github";
      owner = "numtide";
      repo = "flake-utils";
      ref = "main";
    };
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... } @inputs:
  {
    nixosModules = {
      home = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.yuugen = import ./home;
          verbose = true;
        };
        #nix-path.nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
      };
    };

    overlays = import ./overlays;

    nixosConfigurations =
      let
        system = "x86_64-linux";
        shared-overlays = [
          (self: super: {
            packages = import ./pkgs { pkgs = super; };
          })
        ] ++ builtins.attrValues self.overlays;

        sharedModules = [
          home-manager.nixosModule { nixpkgs.overlays = shared-overlays; }
        ] ++ (nixpkgs.lib.attrValues self.nixosModules);
      in
      {
        omen = nixpkgs.lib.nixosSystem
        {
          inherit system;

          modules = [
            ./omen.nix
          ] ++ sharedModules;
        };

        # Template:
        # machine = nixpkgs.lib.nixosSystem
        # {
        #   inherit system;
        #   
        #   modules = [
        #     ./machine.nix
        #   ] ++ sharedModules;
        # };
      };
  };
}
