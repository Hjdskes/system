{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      isDarwin = system: builtins.elem system nixpkgs.lib.platforms.darwin;
      homePrefix = system: if isDarwin system then "/Users" else "/home";

      # Generate a home-manager configuration usable on any Unix system.
      mkHomeConfig = { username, system, extraModules ? [ ] }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [
            ./modules/home-manager
            {
              home = {
                inherit username;
                homeDirectory = "${homePrefix system}/${username}";
              };
            }
          ] ++ extraModules;
        };

    in {
      homeConfigurations = {
        "jente@air" = mkHomeConfig {
          username = "jente";
          system = "aarch64-darwin";
        };
      };
    };
}
