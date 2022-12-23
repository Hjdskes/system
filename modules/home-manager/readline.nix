{ ... }: {
  programs.readline = {
    enable = true;
    includeSystemConfig = false;
    bindings = {
      "\\e[A" = "history-search-backward";
      "\\e[B" = "history-search-forward";
    };
    variables = {
      # Briefly move the cursor to an opening parenthesis when a closing parenthesis is inserted.
      blink-matching-paren = "on";
      #  Display the common prefix of the set of possible completions using a different color.
      colored-completion-prefix = "on";
      # Display possible completions using different colors to indicate their file type.
      colored-stats = "on";
      # The length in characters of the common prefix of a list of possible completions that is
      # dispayed without modification. When set to a value greater than zero, common prefixes
      # longer than this value are replaced with an ellipsis.
      completion-prefix-display-length = 3;
      # Echo a character corresponding to a signal generated from the keyboard.
      echo-control-characters = "off";
      # Configure the terminal in such a way that will enable it to insert each paste into the
      # editing buffer as a single string of characters. This can prevent pasted characters from
      # being interpreted as editing commands.
      enable-bracketed-paste = "off";
      # A character denoting a file's type as reported by stat(2) is appended to the filename when
      # listing possible completions.
      visible-stats = "on";
    };
    # Vim editing mode
    #set editing-mode vi
    #set show-mode-in-prompt on
    #$if term=linux
    #  set vi-ins-mode-string \1\e[?0c\2
    #  set vi-cmd-mode-string \1\e[?8c\2
    #$else
    #  set vi-ins-mode-string \1\e[6 q\2
    #  set vi-cmd-mode-string \1\e[2 q\2
    #$endif
  };
}
