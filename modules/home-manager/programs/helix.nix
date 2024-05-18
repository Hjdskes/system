{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn";
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
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
  };
}
