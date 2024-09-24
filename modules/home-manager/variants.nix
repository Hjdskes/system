{ mac-app-util, ... }:

rec {
  default = import ./.;

  # TODO: apply mac-app-util.homeManagerModules.default in flake.nix?
  mac = { imports = [ default mac-app-util.homeManagerModules.default ]; };
  griffin = { imports = [ default mac-app-util.homeManagerModules.default ]; };
}
