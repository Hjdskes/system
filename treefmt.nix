{
  projectRootFile = "flake.nix";
  programs = {
    nixpkgs-fmt.enable = true;
    shellcheck.enable = true;
  };
  settings.formatter = {
    shellcheck.options = [ "--shell" "bash" ];
  };
}
