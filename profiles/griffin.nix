{ pkgs, ... }: {
  networking.computerName = "Griffin";
  networking.hostName = "griffin";

  environment.systemPackages = with pkgs; [
    _1password
    _1password-gui
    docker
    slack
  ];

  # For applications that aren't available in nixpkgs,
  # or not available for aarch64-darwin.
  # TODO: need to manually install homebrew.
  homebrew = {
    enable = true;
    casks = [
      "linear"
      "notion"
      "signal"
    ];
    # Note: need to be signed into the Mac App Store for mas to successfully
    # install and upgrade applications. Unfortunately apps removed from this
    # option will not be uninstalled automatically even if
    # homebrew.onActivation.cleanup is set to "uninstall" or "zap" (this is
    # currently a limitation of Homebrew Bundle).
    masApps = {
      "1Password for Safari" = 1569813296;
    };
  };
}
