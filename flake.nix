{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, mac-app-util, darwin }@inputs:
    let lib = import ./lib inputs;
    in flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = with pkgs; mkShellNoCC { packages = [ nil ]; };
        checks = lib.mkHomeChecks system // lib.mkShellChecks system;
      }) // {
        homeModules = import ./modules/home-manager/variants.nix inputs;

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

        darwinConfigurations = {
          griffin = lib.mkDarwinConfig {
            extraModules = [ { home-manager.users.jente = self.homeModules.griffin; } ];
          };
        };
      };
}
