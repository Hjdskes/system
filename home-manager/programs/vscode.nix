{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    # TODO: these extensions should probably go to language-specific modules
    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      betterthantomorrow.calva
      jnoortheen.nix-ide
      github.github-vscode-theme
      timonwong.shellcheck
    ];
    userSettings = {
      # TODO: language-specific settings should go to language-specific modules
      "calva.autoOpenInspector" = false;
      "calva.evalOnSave" = true;
      "calva.evaluationSendCodeToOutputWindow" = true;
      "calva.useLegacyReplWindowPath" = false;
      "calva.jackInEnv" = { "PATH" = "\${env:PATH}"; };
      "calva.referencesCodeLens.enabled" = true;
      "editor.bracketPairColorization.enabled" = false;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.lightbulb.enabled" = "off";
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
      "terminal.integrated.enableMultiLinePasteWarning" = "never";
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
      "workbench.colorTheme" = "GitHub Light";
    };
  };
}
