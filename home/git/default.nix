{ pkgs, defaultEmail, ... }: {
  enable = true;
  package = pkgs.gitAndTools.gitFull;
  userName = "Patrick Materer";
  userEmail = defaultEmail;
  ignores = [ "scratch.txt" ".terraform/" ".DS_Store" ".envrc" ];
  aliases = {
    s = "status";
    co = "checkout";
    cob = "checkout -b";
    del = "branch -D";
    br =
      "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
    undo = "reset HEAD~1 --mixed";

    tags = "ls-remote --tags origin";

    log = ''
      !git log --pretty=format:"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]" --abbrev-commit -30'';

    delete-local-merged = ''
      !git fetch && git branch --merged | xargs git branch -d
    '';

    nuke = ''
      !git branch -D $1 && git push origin :$1
    '';
  };
  # https://blog.gitbutler.com/how-git-core-devs-configure-git/
  extraConfig = {
    column.ui = "auto";
    branch.sort = "-committerdate";
    tag.sort = "version:refname";
    init.defaultBranch = "main";
    diff = {
      algorithm = "histogram";
      colorMoved = "plain";
      mnemonicPrefix = true;
      renames = true;
    };
    push = {
      default = "simple";
      autoSetupRemote = true;
      followTags = true;
    };
    fetch = {
      prune = true;
      pruneTags = true;
      all = true;
    };
    help.autocorrect = "prompt";
    commit.verbose = true;
    rerere = {
      enabled = true;
      autoupdate = true;
    };

    core.editor = "vim";

    rebase = {
      autoSquash = true;
      autoStash = true;
      updateRefs = true;
    };

    credential.helper = "store";
    color.ui = true;
  };
}
