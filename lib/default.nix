{ self, nixpkgs, ... }:
with nixpkgs.lib; {
  mkHomeChecks = system:
    mapAttrs'
    (name: home: nameValuePair "home-manager.${name}" home.activationPackage)
    (filterAttrs (_: home: home.pkgs.system == system)
      (self.homeConfigurations or { }));

  mkShellChecks = system:
    mapAttrs' (name: shell: nameValuePair "devshell.${name}" shell)
    (self.devShells."${system}" or { });
}
