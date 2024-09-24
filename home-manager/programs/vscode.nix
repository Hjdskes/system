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
    # See https://github.com/nix-community/home-manager/issues/5372.
    mutableExtensionsDir = false;
    userSettings = {
      # TODO: language-specific settings should go to language-specific modules
      "calva.autoOpenInspector" = false;
      "calva.evalOnSave" = true;
      "calva.evaluationSendCodeToOutputWindow" = true;
      "calva.jackInEnv" = { "PATH" = "\${env:PATH}"; };
      "calva.useLegacyReplWindowPath" = false;
      "calva.referencesCodeLens.enabled" = true;
      "editor.bracketPairColorization.enabled" = false;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.lightbulb.enabled" = "off";
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "selection";
      "editor.smoothScrolling" = true;
      "editor.tabSize" = 2;
      "editor.dragAndDrop" = false;
      "editor.linkedEditing" = true;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "extensions.ignoreRecommendations" = true;
      "diffEditor.experimental.showMoves" = true;
      "diffEditor.ignoreTrimWhitespace" = false;
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;
      "git.rebaseWhenSync" = true;
      "search.smartCase" = true;
      "search.useGlobalIgnoreFiles" = true;
      "search.useIgnoreFiles" = true;
      "security.workspace.trust.untrustedFiles" = "open";
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.enableMultiLinePasteWarning" = "never";
      "terminal.integrated.smoothScrolling" = true;
      "window.autoDetectColorScheme" = true;
      "window.commandCenter" = true;
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "GitHub Light";
      "workbench.editor.enablePreview" = false;
      "workbench.editor.highlightModifiedTabs" = true;
      "workbench.enableExperiments" = false;
      "workbench.iconTheme" = "vs-seti";
      "workbench.preferredDarkColorTheme" = "GitHub Dark";
      "workbench.preferredLightColorTheme" = "GitHub Light";
      "workbench.productIconTheme" = "Default";
      "workbench.tips.enabled" = false;
      "workbench.tree.indent" = 12;
    };
  };
}
