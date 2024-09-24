{ ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "solarized_light";
      editor = {
        bufferline = "multiple";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        line-number = "relative";
        lsp = { display-messages = true; };
      };
    };
  };
}
