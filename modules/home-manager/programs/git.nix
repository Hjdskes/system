{ pkgs, ... }: {
  programs.git = {
    enable = true;
    aliases = {
      fix = "commit --amend --no-edit";
      wip =
        "for-each-ref --sort='authordate:iso8601' --format=' %(color:green)%(authordate:relative)%09%(color:white)%(refname:short)' refs/head";
    };
    includes = [
      {
        condition = "gitdir:~/griffin/";
        contents = {
          user = {
            email = "jente@griffin.com";
            signingkey =
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJu8RqWEKSTl/hC9d0c1+c3I8LjXFk8+hm9QAK0a5Iei griffin";
          };
          commit = { gpgSign = true; };
          gpg = { format = "ssh"; };
        };
      }
      {
        condition = "gitdir:~/src/";
        contents = {
          user = {
            email = "dev@hjdskes.nl";
            # TODO: figure out signing keys between different personal machines
            signingkey =
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICnWF7deQFrUBRMuqXzi8U9N3W9GrrY+ik/Mhr3Q7jTY jente@air";
          };
          commit = { gpgSign = true; };
          gpg = { format = "ssh"; };
        };
      }
    ];
    extraConfig = {
      user = { name = "Jente Hidskes Ankarberg"; };
      core = {
        editor = "hx";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        autocrlf = "input";
      };
      credential = {
        helper = if pkgs.stdenvNoCC.isDarwin then "osxkeychain" else "cache";
      };
      status = { showUntrackedFiles = "no"; };
      rebase = { autostash = true; };
      diff = {
        noprefix = true;
        algorithm = "minimal";
      };
      pull = { rebase = true; };
      push = {
        default = "simple";
        useForceIfIncludes = true;
      };
      init = { defaultBranch = "main"; };
      fetch = { prune = true; };
      merge = { conflictStyle = "zdiff3"; };
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
