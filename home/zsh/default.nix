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
    source ${config.age.secrets.environment.path}

    source <(kubectl completion zsh)

    . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
    . "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"

    export PATH=$PATH:~/.npm/bin
    export PATH="$HOME/.krew/bin:$PATH"
    export PATH="$HOME/bin:$PATH"

    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    [[ -f $PYENV_ROOT/plugins/pyenv-virtualenv ]] && eval "$(pyenv virtualenv-init -)"

  '' + (if pkgs.stdenv.isLinux then ''
    export OVMF_PATH="${pkgs.OVMF.fd}/FV"
  '' else
    "");

  shellAliases = {
    switch = "darwin-rebuild switch --flake ~/.config/nix";

    diff = "${pkgs.colordiff}/bin/colordiff";

    here = "pwd | pbcopy";

    cat = "${pkgs.bat}/bin/bat";

    # kubernetes
    k = "${pkgs.kubectl}/bin/kubectl";

    kx = "${pkgs.kubie}/bin/kubie ctx";
    kn = "${pkgs.kubie}/bin/kubie ns";

    netshoot = "k run tmp-shell --rm -i --tty --image nicolaka/netshoot";
    kill-pod = "k delete pod --force --grace-period=0";

    ctar = "${pkgs.gnutar}/bin/tar -czvf";
    otar = "${pkgs.gnutar}/bin/tar -xcf";

    nixsearch = "nix search nixpkgs";

    # terraform
    tf = "terraform";
    tfi = "terraform init";
    tfiu = "terraform init -upgrade";
    tff = "terraform fmt";
    tfp = "terraform plan";
    tfa = "terraform apply";
    tfaa = "terraform apply -auto-approve";
    tfc = "terraform-docs . && terraform fmt && tflint";

    spt = "spotify_player";
  };

  sessionVariables = {
    # https://consoledonottrack.com/
    DO_NOT_TRACK = 1;
    HOMEBREW_NO_ANALYTICS = 1;

    AWS_PAGER = "";
    AWS_CA_BUNDLE = config.age.secrets.certs.path;
    NODE_EXTRA_CA_CERTS = config.age.secrets.certs.path;
    AWS_DEFAULT_REGION = "us-east-1";
  };
}
