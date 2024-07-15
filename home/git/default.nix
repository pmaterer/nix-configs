{ pkgs, ... }: {
  enable = true;
  package = pkgs.gitAndTools.gitFull;
  userName = "Patrick Materer";
  # userEmail = "patrick.materer@socure.com";
  userEmail = "patrickmaterer@gmail.com";
  ignores = [ "scratch.txt" ".terraform/" ".DS_Store" ".envrc" ];
  aliases = {
    s = "status";
    co = "checkout";
    cob = "checkout -b";
    del = "branch -D";
    br =
      "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
    undo = "reset HEAD~1 --mixed";

    log = ''
      !git log --pretty=format:"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]" --abbrev-commit -30'';
  };
  extraConfig = {
    core.editor = "vim";
    fetch.prune = true;
    credential.helper = "store";
    color.ui = true;
    push.autoSetupRemote = true;
    init.defaultBranch = "main";
  };
}
