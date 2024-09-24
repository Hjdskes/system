{
  description = "My Nixified system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, mac-app-util, treefmt-nix }@inputs:
    let lib = import ./lib inputs;
    in flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          treefmt = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        in
        {
          devShells.default = with pkgs; mkShellNoCC { packages = [ treefmt.config.build.wrapper ]; };
          checks = lib.mkHomeChecks system // lib.mkShellChecks system
            // { formatting = treefmt.config.build.check self; };
          formatter = treefmt.config.build.wrapper;
        }) // {
      homeModules = import ./home-manager/variants.nix inputs;

      homeConfigurations = {
        mac = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [ self.homeModules.mac ];
        };

        griffin = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [ self.homeModules.griffin ];
        };
      };
    };
}
