{ config, nixpkgs, pkgs, ... }: {
  users.users.jente = {
    description = "Jente Hidskes Ankarberg";
    home = "${if pkgs.stdenvNoCC.isDarwin then "/Users" else "/home"}/${config.users.users.jente.name}";
    shell = pkgs.bashInteractive;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # TODO: refer to home manager variants or pass this in
    users.jente = import ./home-manager;
  };

  environment = {
    shells = with pkgs; [ bashInteractive ];
  };

  time.timeZone = "Europe/Stockholm";

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix = {
    extraOptions = ''
      keep-outputs = true
      experimental-features = nix-command flakes
    '';

    settings = {
      trusted-users = [ "${config.users.users.jente.name}" "root" "@wheel" ];
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://hjdskes.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hjdskes.cachix.org-1:myagc5XavzRr97YDozKzS8PajQCT9I1z3p6zsvsRtMY="
      ];
    };

    gc = {
      automatic = true;
      # TODO: this is NixOS-specific; move this to NixOS module
      # dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # See https://www.tweag.io/blog/2020-07-31-nixos-flakes/#pinning-nixpkgs
    # TODO: make this work
    # registry.nixpkgs.flake = nixpkgs;
  };
}
