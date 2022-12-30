{
  description = "My Nixified system configurations";

  nixConfig = {
    substituters = [ "https://cache.nixos.org" "https://hjdskes.cachix.org" ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hjdskes.cachix.org-1:myagc5XavzRr97YDozKzS8PajQCT9I1z3p6zsvsRtMY="
    ];
  };

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;
    utils.url = github:numtide/flake-utils;
    treefmt-nix.url = "github:numtide/treefmt-nix";
    home-manager = {
      url = github:nix-community/home-manager/release-22.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, treefmt-nix, utils, home-manager, darwin, ... }:
    let
      inherit (utils.lib) eachSystemMap;
      defaultSystems = [ "aarch64-darwin" "x86_64-linux" ];
      treefmt = pkgs: treefmt-nix.lib.mkWrapper pkgs (import ./treefmt.nix);
      isDarwin = system: builtins.elem system nixpkgs.lib.platforms.darwin;
      homePrefix = system: if isDarwin system then "/Users" else "/home";

      # Generate a Darwin configuration.
      mkDarwinConfig =
        { system ? "aarch64-darwin"
        , baseModules ? [
            ./modules/darwin
            home-manager.darwinModules.home-manager
          ]
        , extraModules ? [ ]
        ,
        }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = baseModules ++ extraModules;
        };

      # Generate a home-manager configuration usable on any Unix system.
      mkHomeConfig =
        { username
        , system
        , baseModules ? [
            ./modules/home-manager
            {
              home = {
                inherit username;
                homeDirectory = "${homePrefix system}/${username}";
              };
            }
          ]
        , extraModules ? [ ]
        }:
        home-manager.lib.homeManagerConfiguration rec {
          pkgs = import nixpkgs { inherit system; };
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
          } // (nixpkgs.lib.optionalAttrs (isDarwin system) {
            # TODO: just add this to the attrset when NixOS support is in
            "${system}-${username}" =
              self.darwinConfigurations."${username}@${system}".config.system.build.toplevel;
          });
        };
    in
    {
      homeConfigurations = {
        "jente@aarch64-darwin" = mkHomeConfig {
          username = "jente";
          system = "aarch64-darwin";
        };
        "jente@x86_64-linux" = mkHomeConfig {
          username = "jente";
          system = "x86_64-linux";
        };
      };

      darwinConfigurations = {
        "jente@aarch64-darwin" = mkDarwinConfig {
          system = "aarch64-darwin";
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

      checks = { }
        // mkCheck { system = "aarch64-darwin"; username = "jente"; }
        // mkCheck { system = "x86_64-linux"; username = "jente"; };

      formatter = eachSystemMap defaultSystems (
        system: (treefmt (import nixpkgs { inherit system; }))
      );
    };
}
