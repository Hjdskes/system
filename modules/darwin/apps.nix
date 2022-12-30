{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    iterm2
  ];

  # For applications that aren't available in nixpkgs,
  # or not available for aarch64-darwin.
  # TODO: need to manually install homebrew.
  homebrew = {
    enable = true;
    casks = [
      "spotify"
    ];
  };
}
