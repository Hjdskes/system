{ pkgs, ... }: {
  imports = [
    ./programs/bash
    ./programs/helix.nix
    ./programs/git.nix
    ./programs/readline.nix
  ];

  nixpkgs.config = { allowUnfree = true; };

  home = {
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";

    # The set of packages to appear in the user environment, taken
    # from nixpkgs.
    packages = with pkgs; [
      colordiff
      coreutils-full
      git
      gnugrep
      gnused
      iterm2 # TODO: configure
      jq
      spotify
      tree
    ];

    # Extra directories to add to PATH.
    sessionPath = [ ];

    # Environment variables to always set at login.
    sessionVariables = {
      EDITOR = "hx";
      PAGER = "less";
    };

  };

  programs = {
    dircolors.enable = true;
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
