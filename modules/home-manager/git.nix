{ pkgs, ... }: {
  programs.git = {
    enable = true;
    aliases = {
      fix = "commit --amend --no-edit";
      wip = "for-each-ref --sort='authordate:iso8601' --format=' %(color:green)%(authordate:relative)%09%(color:white)%(refname:short)' refs/head";
    };
    includes = [
      {
        condition = "gitdir:~/griffin/";
        contents =
          {
            user = {
              email = "jente@griffin.sh";
              signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJu8RqWEKSTl/hC9d0c1+c3I8LjXFk8+hm9QAK0a5Iei griffin";
            };
            commit = {
              gpgSign = true;
            };
            gpg = {
              format = "ssh";
            };
          };
      }
      {
        condition = "gitdir:~/src/";
        contents = {
          user = {
            email = "dev@hjdskes.nl";
            signingkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCr0rair5PziFCPOAquZuTGs2XXNxozn160FBxK2uSN8vkOhjYLsqatJq7CYLHu9hvhEI7Lnz4ummyZA3jIqMB/3lW0GwnPpWHy71Mf8zyRhw3tZe6M1sg8nPH13uQl2ACpWuGqSe8Wb2RnmcQwRoGK2pVTiG2T1yig5I5zgIIlbkCBco6qVsLQb35u3fmrBSIZaucr4VpgnxbRj2fNmvqbaaGtLgJ5bTn+Us/+/uMfTZ8O362QaVVPURtuh55K+kfuTND2PW9vRYwmvTUZeXyYpuZE1XKRm9wrj7P6716Oko7IikPp9qY5Wqe0+FDarper4zCQ2ojENEF0u76QwfOF";
          };
          commit = {
            gpgSign = true;
          };
          gpg = {
            format = "ssh";
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
