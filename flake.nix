{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager }@inputs:
    let lib = import ./lib inputs;
    in flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = with pkgs; mkShellNoCC { packages = [ nil ]; };
        checks = lib.mkHomeChecks system // lib.mkShellChecks system;
      }) // {
        homeConfigurations = {
          "jente@air" = lib.mkHomeConfig {
            username = "jente";
            system = "aarch64-darwin";
          };
        };
      };

}
