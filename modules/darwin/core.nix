{ config, pkgs, ... }: {
  environment = {
    loginShell = pkgs.bashInteractive;
  };

  nix = {
    gc.interval = {
      Weekday = 1;
      Hour = 3;
      Minute = 15;
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
