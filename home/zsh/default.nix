{ pkgs, config, ... }: {
  enable = true;

  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  autocd = true;
  defaultKeymap = "emacs";

  history.size = 10000;
  history.path = "${config.xdg.dataHome}/zsh/history";

  initExtra = ''
    [[ -f $HOME/.secrets.zsh ]] && source $HOME/.secrets.zsh

    source <(kubectl completion zsh)

    . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
    . "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"

    export PATH=$PATH:~/.npm/bin

    export PATH="$HOME/.krew/bin:$PATH"

    eval "$(pyenv virtualenv-init -)"
  '';

  shellAliases = {
    switch = "darwin-rebuild switch --flake ~/.config/nix";

    diff = "${pkgs.colordiff}/bin/colordiff";

    here = "pwd | pbcopy";

    cat = "${pkgs.bat}/bin/bat";

    k = "${pkgs.kubectl}/bin/kubectl";
    kx = "${pkgs.kubectx}/bin/kubectx";
    kn = "${pkgs.kubectx}/bin/kubens";
    netshoot = "k run tmp-shell --rm -i --tty --image nicolaka/netshoot";
    kill-pod = "k delete pod --force --grace-period=0";

    ctar = "${pkgs.gnutar}/bin/tar -czvf";
    otar = "${pkgs.gnutar}/bin/tar -xcf";

    nixsearch = "nix search nixpkgs";

    tf = "terraform";
    tff = "terraform fmt";
    tfp = "terraform plan";
    tfa = "terraform apply";
    tfaa = "terraform apply -auto-approve";
    tfc = "terraform-docs . && terraform fmt && tflint";
  };

  sessionVariables = {
    # https://consoledonottrack.com/
    DO_NOT_TRACK = 1;
    HOMEBREW_NO_ANALYTICS = 1;

    AWS_PAGER = "";
    AWS_CA_BUNDLE = "/Users/pmaterer/FW_BUNDLE.crt";
    NODE_EXTRA_CA_CERTS = "/Users/pmaterer/FW_BUNDLE.crt";
    AWS_DEFAULT_REGION = "us-east-1";
  };
}
