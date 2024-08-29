{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    # TODO: these extensions should probably go to language-specific modules
    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      bbenoist.nix
      betterthantomorrow.calva
      brettm12345.nixfmt-vscode
      github.github-vscode-theme
      timonwong.shellcheck
    ];
    userSettings = {
      "editor.bracketPairColorization.enabled" = false;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.lightbulb.enabled" = false;
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "selection";
      "editor.smoothScrolling" = true;
      "editor.tabSize" = 2;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "extensions.ignoreRecommendations" = true;
      "git.rebaseWhenSync" = true;
      "search.smartCase" = true;
      "search.useGlobalIgnoreFiles" = true;
      "search.useIgnoreFiles" = true;
      "security.workspace.trust.untrustedFiles" = "open";
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.enableMultiLinePasteWarning" = false;
      "window.autoDetectColorScheme" = true;
      "window.commandCenter" = true;
      "window.titleBarStyle" = "custom";
      "workbench.preferredDarkColorTheme" = "GitHub Dark";
      "workbench.preferredLightColorTheme" = "GitHub Light";
      "workbench.productIconTheme" = "Default";
      "workbench.enableExperiments" = false;
      "workbench.iconTheme" = "vs-seti";
      "workbench.tips.enabled" = false;
      "workbench.tree.indent" = 12;
    };
  };
}
