{ ... }: {
  system.defaults = {
    CustomUserPreferences = {
      NSGlobalDomain = {
        AppleAccentColor = "5";
        AppleHighlightColor = "0.968627 0.831373 1.000000 Purple";
        AppleLocale = "sv_SE";
      };

      # TODO: add these options upstream under finder.
      "com.apple.finder" = {
        NewWindowTarget = "PfHm";
        ShowExternalHardDrivesOnDesktop = 1;
        ShowHardDrivesOnDesktop = 0;
        ShowRemovableMediaOnDesktop = 1;
        ShowSidebar = 1;
        QuitMenuItem = true;
      };

      "com.googlecode.iterm2" = {
        PromptOnQuit = false;
        QuitWhenAllWindowsClosed = 1;
        TabStyleWithAutomaticOption = 5;
        # TODO: requires array support in nix-darwin
        # "New Bookmarks" = [
        #   "Ansi 0 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.1176470592617989";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.09803921729326248";
        #     "Red Component" = "0.0784313753247261";
        #   };
        #   "Ansi 1 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.1630003750324249";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.2366006970405579";
        #     "Red Component" = "0.7074432373046875";
        #   };
        #   "Ansi 10 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.5654193758964539";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.9042816162109375";
        #     "Red Component" = "0.3450070321559906";
        #   };
        #   "Ansi 11 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = 0;
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.8833775520324707";
        #     "Red Component" = "0.9259033203125";
        #   };
        #   "Ansi 12 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.9485321044921875";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.6704471707344055";
        #     "Red Component" = "0.6534907817840576";
        #   };
        #   "Ansi 13 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.8821563720703125";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.4927266538143158";
        #     "Red Component" = "0.8821563720703125";
        #   };
        #   "Ansi 14 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = 1;
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.9926329255104065";
        #     "Red Component" = "0.3759753108024597";
        #   };
        #   "Ansi 15 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = 1;
        #     "Color Space" = "sRGB";
        #     "Green Component" = 1;
        #     "Red Component" = "0.9999960064888";
        #   };
        #   "Ansi 2 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = 0;
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.7607843279838562";
        #     "Red Component" = 0;
        #   };
        #   "Ansi 3 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = 0;
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.7695948481559753";
        #     "Red Component" = "0.7805864810943604";
        #   };
        #   "Ansi 4 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.7821617722511292";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.2647435665130615";
        #     "Red Component" = "0.1540430039167404";
        #   };
        #   "Ansi 5 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.7449436187744141";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.2493168413639069";
        #     "Red Component" = "0.752197265625";
        #   };
        #   "Ansi 6 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.7816620469093323";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.7742590308189392";
        #     "Red Component" = 0;
        #   };
        #   "Ansi 7 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.7810482978820801";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.7810582518577576";
        #     "Red Component" = "0.7810397744178772";
        #   };
        #   "Ansi 8 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.4078223705291748";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.4078278839588165";
        #     "Red Component" = "0.4078176021575928";
        #   };
        #   "Ansi 9 Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.4583322405815125";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.4752407670021057";
        #     "Red Component" = "0.8659515380859375";
        #   };
        #   "Background Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.12103271484375";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.09911105036735535";
        #     "Red Component" = "0.0806884765625";
        #   };
        #   "Badge Color" = {
        #     "Alpha Component" = "0.5";
        #     "Blue Component" = 1;
        #     "Color Space" = "sRGB";
        #     "Green Component" = 1;
        #     "Red Component" = 1;
        #   };
        #   "Bold Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = 1;
        #     "Color Space" = "sRGB";
        #     "Green Component" = 1;
        #     "Red Component" = "0.9999960064888";
        #   };
        #   "Cursor Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.9999872446060181";
        #     "Color Space" = "sRGB";
        #     "Green Component" = 1;
        #     "Red Component" = "0.9999763369560242";
        #   };
        #   "Cursor Guide Color" = {
        #     "Alpha Component" = "0.25";
        #     "Blue Component" = 1;
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.9268307089805603";
        #     "Red Component" = "0.7021318674087524";
        #   };
        #   "Cursor Text Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = 0;
        #     "Color Space" = "sRGB";
        #     "Green Component" = 0;
        #     "Red Component" = 0;
        #   };
        #   "Foreground Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.8619885444641113";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.86199951171875";
        #     "Red Component" = "0.8619791269302368";
        #   };
        #   "Link Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = "0.9337158203125";
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.5578983426094055";
        #     "Red Component" = "0.1980242282152176";
        #   };
        #   "Selected Text Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = 0;
        #     "Color Space" = "sRGB";
        #     "Green Component" = 0;
        #     "Red Component" = 0;
        #   };
        #   "Selection Color" = {
        #     "Alpha Component" = 1;
        #     "Blue Component" = 1;
        #     "Color Space" = "sRGB";
        #     "Green Component" = "0.843137264251709";
        #     "Red Component" = "0.7019608020782471";
        #   };
        #];
      };
    };

    # TODO: would be nice if we could specify which applications to be docked
    dock = {
      autohide = true;
      minimize-to-application = true;
      mouse-over-hilite-stack = true;
      show-recents = false;
      tilesize = 48;
      wvous-br-corner = 1;
    };

    NSGlobalDomain = {
      "com.apple.trackpad.scaling" = 0.875;
      "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
    };

    ".GlobalPreferences" = {
      "com.apple.mouse.scaling" = "3.0";
    };

    alf.globalstate = 1;
    finder.ShowPathbar = true;
    loginwindow.GuestEnabled = false;
    magicmouse.MouseButtonMode = "TwoButton";
    trackpad.TrackpadRightClick = true;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  security.pam.enableSudoTouchIdAuth = true;
}
