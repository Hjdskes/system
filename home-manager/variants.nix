rec {
  default = import ./.;

  griffin = { imports = [ default ]; };
}
