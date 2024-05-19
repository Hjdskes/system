{ self, nixpkgs, home-manager, ... }:
with nixpkgs.lib; rec {
  isDarwin = system: builtins.elem system platforms.darwin;
  homePrefix = system: if isDarwin system then "/Users" else "/home";

  # Generate a home-manager configuration usable on any Unix system.
  # TODO: revisit this
  mkHomeConfig = { username, system, extraModules ? [ ] }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { inherit system; };
      modules = [
        ../modules/home-manager
        {
          home = {
            inherit username;
            homeDirectory = "${homePrefix system}/${username}";
          };
        }
      ] ++ extraModules;
    };

  mkHomeChecks = system:
    mapAttrs'
    (name: home: nameValuePair "home-manager.${name}" home.activationPackage)
    (filterAttrs (_: home: home.pkgs.system == system)
      (self.homeConfigurations or { }));

  mkShellChecks = system:
    mapAttrs' (name: shell: nameValuePair "devshell.${name}" shell)
    (self.devShells."${system}" or { });

}
