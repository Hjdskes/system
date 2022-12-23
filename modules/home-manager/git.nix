{ pkgs, ... }: {
  programs.git = {
    enable = true;
    aliases = {
      wip = "for-each-ref --sort='authordate:iso8601' --format=' %(color:green)%(authordate:relative)%09%(color:white)%(refname:short)' refs/head";
    };
    includes = [
      {
        condition = "gitdir:~/src/";
        contents = {
          user = {
            email = "dev@hjdskes.nl";
          };
        };
      }
    ];
    extraConfig = {
      user = {
        name = "Jente Hidskes Ankarberg";
      };
      core = {
        editor = "nvim";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        autocrlf = "input";
      };
      credential = {
        helper =
          if pkgs.stdenvNoCC.isDarwin
          then "osxkeychain"
          else "cache";
      };
      status = { showUntrackedFiles = "no"; };
      rebase = { autostash = true; };
      diff = {
        noprefix = true;
        algorithm = "minimal";
      };
      pull = { rebase = true; };
      push = { default = "simple"; };
      init = { defaultBranch = "main"; };
      fetch = { prune = true; };
      merge = {
        conflictStyle = "zdiff3";
      };
      aliases = {
        fix = "commit --amend --no-edit";
      };
      # TODO: go over colors: https://git-scm.com/docs/git-config
      color.branch = {
        current = "yellow reverse";
        local = "yellow";
        remote = "green";
      };
      color.diff = {
        meta = "yellow bold";
        frag = "magenta bold";
        old = "red bold";
        new = "green bold";
        whitespace = "red reverse";
      };
      color.status = {
        added = "yellow";
        changed = "green";
        untracked = "cyan";
      };
    };
    ignores = [
      ".bloop/"
      ".direnv/"
      ".idea/"
      ".metals/"
      ".terraform/"
      ".vscode/"
      "metals.sbt"
      "target/"
      ".bsp/"
      "cabal.project.local"
      "hie.yaml"
      ".envrc"
      "*.code-workspace"
    ];
  };
}
