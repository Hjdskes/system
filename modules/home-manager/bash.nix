{ pkgs, ... }: {
  programs.bash = {
    enable = true;
    bashrcExtra = "";
    historyControl = [ "ignoredups" "ignorespace" "erasedups" ];
    initExtra = ''
      if [[ -r ${pkgs.git}/share/bash-completion/completions/git ]]; then
        source ${pkgs.git}/share/bash-completion/completions/git
      fi
      PROMPT_COMMAND=__prompt_command

      function __prompt_command() {
        local RED="\e[31m"
        local GREEN="\e[32m"
        local BLUE="\e[34m"
        local RESET="\e[0m"

        if [[ $? -ne 0 ]]; then
          local EXIT="$RED"
        else
          local EXIT="$GREEN"
        fi

        if [[ -n "$IN_NIX_SHELL" ]]; then
          local PROMPT='λ'
        else
          local PROMPT='>'
        fi

        local PRE="\n$BLUE\w$RESET "
        local FORMAT="%s$RESET "
        local POST="$RESET\t\n $PROMPT "

        if [[ -r ${pkgs.git}/share/bash-completion/completions/git-prompt.sh ]]; then
          source ${pkgs.git}/share/bash-completion/completions/git-prompt.sh

          GIT_PS1_SHOWDIRTYSTATE=1
          GIT_PS1_SHOWSTASHSTATE=0
          GIT_PS1_SHOWUNTRACKEDFILES=0
          GIT_PS1_SHOWCOLORHINTS=1
          GIT_PS1_DESCRIBE_STYLE=branch
          GIT_PS1_SHOWUPSTREAM=auto

          __git_ps1 "$PRE" "$POST" "$FORMAT"
        else
          PS1="$PRE$POST"
        fi
      }

      ${builtins.readFile ./functions.sh}
    '';

    logoutExtra = ''
      if [ "$SHLVL" = 1 ]; then
        [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
      fi
    '';

    shellOptions = [ "histappend" "checkwinsize" "no_empty_cmd_completion" ];

    shellAliases = {
      df = "df -h";
      diff = "colordiff -up";
      du = "du -h";
      free = "free -m";
      ls = "ls -G";
      mkdir = "mkdir -p -v";
      ".." = "cd ..";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
