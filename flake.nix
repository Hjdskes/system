{
  description = "My Nixified system configurations";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;
    utils.url = github:numtide/flake-utils;
    treefmt-nix.url = "github:numtide/treefmt-nix";
    home-manager = {
      url = github:nix-community/home-manager/release-22.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, treefmt-nix, utils, home-manager, ... }:
    let
      inherit (utils.lib) eachSystemMap;
      defaultSystems = [ "x86_64-linux" ];
      treefmt = pkgs: treefmt-nix.lib.mkWrapper pkgs (import ./treefmt.nix);

      # Generate a home-manager configuration usable on any Unix system.
      mkHomeConfig =
        { username
        , system
        , baseModules ? [
            ./modules/home-manager
            {
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
              };
            }
          ]
        , extraModules ? [ ]
        }:
        home-manager.lib.homeManagerConfiguration rec {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = { inherit nixpkgs; };
          modules = baseModules ++ extraModules;
        };

      mkCheck =
        { system
        , username
        ,
        }: {
          "${system}" = {
            "home-manager-${username}" =
              self.homeConfigurations."${username}@${system}".activationPackage;
            devShell = self.devShells."${system}".default;
          };
        };
    in
    {
      homeConfigurations = {
        "jente@x86_64-linux" = mkHomeConfig {
          username = "jente";
          system = "x86_64-linux";
        };
      };

      devShells = eachSystemMap defaultSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = [
              (treefmt pkgs)
            ];
          };
        });

      checks = { } // mkCheck { system = "x86_64-linux"; username = "jente"; };

      formatter = eachSystemMap defaultSystems (
        system: (treefmt (import nixpkgs { inherit system; }))
      );
    };
}
