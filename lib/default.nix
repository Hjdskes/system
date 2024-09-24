{ self, nixpkgs, darwin, home-manager, ... }:
with nixpkgs.lib; {
  mkHomeChecks = system:
    mapAttrs'
    (name: home: nameValuePair "home-manager.${name}" home.activationPackage)
    (filterAttrs (_: home: home.pkgs.system == system)
      (self.homeConfigurations or { }));

  mkShellChecks = system:
    mapAttrs' (name: shell: nameValuePair "devshell.${name}" shell)
    (self.devShells."${system}" or { });

  # TODO: is this really needed?
  mkDarwinConfig =
    { system ? "aarch64-darwin"
    , baseModules ? [ ../modules/darwin home-manager.darwinModules.home-manager ]
    , extraModules ? [ ]
    }:
    darwin.lib.darwinSystem {
      inherit system;
      modules = baseModules ++ extraModules;
    };
}
