{ pkgs, ... }: {
  home.packages = with pkgs; [ iterm2 ];
  xdg.configFile."iterm2/com.googlecode.iterm2.plist".source =
    ./com.googlecode.iterm2.plist;
}
