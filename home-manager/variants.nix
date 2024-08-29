{ mac-app-util, ... }:

rec {
  default = import ./.;

  mac = { imports = [ default mac-app-util.homeManagerModules.default ]; };
  griffin = { imports = [ default ]; };
}
