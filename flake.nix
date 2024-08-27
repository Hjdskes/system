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
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, mac-app-util }@inputs:
    let lib = import ./lib inputs;
    in flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = with pkgs; mkShellNoCC { packages = [ nil ]; };
        checks = lib.mkHomeChecks system // lib.mkShellChecks system;
      }) // {
        homeModules = import ./home-manager/variants.nix;

        homeConfigurations = {
          default = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
            modules = [
              self.homeModules.default
              mac-app-util.homeManagerModules.default
            ];
          };

          griffin = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
            modules = [
              self.homeModules.griffin
              mac-app-util.homeManagerModules.default
            ];
          };
        };
      };
}
