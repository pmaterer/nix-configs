{ pkgs, config, ... }:
let
  git = "${pkgs.git}/bin/git";
  asdfShare = "${pkgs.asdf-vm}/share";
in {
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

    . "${asdfShare}/asdf-vm/asdf.sh"
    . "${asdfShare}/asdf-vm/completions/asdf.bash"

    export PATH=$PATH:~/.npm/bin
    export PATH="$HOME/.krew/bin:$PATH"
    export PATH="$HOME/bin:$PATH"
    export PATH="$HOME/.local/bin.go:$PATH"
    export PATH="$HOME/nonix-bin:$PATH"

    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    [[ -f $PYENV_ROOT/plugins/pyenv-virtualenv ]] && eval "$(pyenv virtualenv-init -)"

    eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

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

    k-pods-count =
      "${pkgs.kubectl}/bin/kubectl get pods --all-namespaces -o json | jq -r '.items | group_by(.metadata.namespace) | map({\"namespace\": .[0].metadata.namespace, \"running_pods\": map(select(.status.phase == \"Running\")) | length}) | sort_by(.namespace) | .[] | \"(.namespace): (.running_pods)\"'";

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

    # git
    gs = "${git} status";

    gc = "${git} checkout";
    gcb = "${git} checkout -b";

    ga = "${git} add .";
    gap = "${git} add -p";

    gb =
      "${git} branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";

    gdc = "${git} diff --cached";

    gpt = ''${git} add . && ${git} commit -m "Testing" && ${git} push'';

    # gitlab
    glopen = "${pkgs.glab}/bin/glab repo view -w";

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
