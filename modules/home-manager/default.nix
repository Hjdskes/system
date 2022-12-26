{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./git.nix
    ./readline.nix
    # ./ssh.nix
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
    stateVersion = "22.11";

    # Extra directories to add to PATH.
    sessionPath = [ "~/.local/bin" ];

    # Environment variables to always set at login.
    sessionVariables = {
      GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
      EDITOR = "nvim";
      PAGER = "less";
    };

    packages = with pkgs; [
      colordiff
      tree
    ];
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    dircolors.enable = true;
  };
}
