{
  pkgs,
  config,
  ...
}: let
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

  initExtra =
    ''
      # Speed up compinit by only checking once a day
      autoload -Uz compinit
      if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
        compinit
      else
        compinit -C
      fi

      # Consolidated PATH management
      export PYENV_ROOT="$HOME/.pyenv"
      typeset -U path
      path=(
        "$HOME/bin"
        "$HOME/.local/bin.go"
        "$HOME/.npm/bin"
        "$HOME/.krew/bin"
        "$HOME/nonix-bin"
        "$PYENV_ROOT/bin"(N)
        $path
      )

      # Source secrets
      source ${config.age.secrets.environment.path}

      # ASDF setup
      . "${asdfShare}/asdf-vm/asdf.sh"
      fpath=(${asdfShare}/asdf-vm/completions $fpath)
      [[ -d "$HOME/.asdf/plugins/java" ]] && . ~/.asdf/plugins/java/set-java-home.zsh

      # Fast tools - load immediately
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"

      # Deferred completions (loads in background after prompt appears)
      zsh-defer -c 'source <(${pkgs.kubectl}/bin/kubectl completion zsh)'

      # Lazy load pyenv (only when called)
      pyenv() {
        unfunction pyenv
        eval "$(command pyenv init -)"
        [[ -f $PYENV_ROOT/plugins/pyenv-virtualenv/bin/pyenv-virtualenv-init ]] && \
          eval "$(command pyenv virtualenv-init -)"
        pyenv "$@"
      }

    ''
    + (
      if pkgs.stdenv.isLinux
      then ''
        export OVMF_PATH="${pkgs.OVMF.fd}/FV"
      ''
      else ""
    );

  shellAliases = {
    ls = "${pkgs.eza}/bin/eza --icons --git";
    ll = "${pkgs.eza}/bin/eza -la --icons --git";
    tree = "${pkgs.eza}/bin/eza --tree --icons";

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

    k-pods-count = "${pkgs.kubectl}/bin/kubectl get pods --all-namespaces -o json | jq -r '.items | group_by(.metadata.namespace) | map({\"namespace\": .[0].metadata.namespace, \"running_pods\": map(select(.status.phase == \"Running\")) | length}) | sort_by(.namespace) | .[] | \"(.namespace): (.running_pods)\"'";

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
    tft = "terraform test";
    tfc = "terraform-docs . && terraform fmt && tflint";

    spt = "spotify_player";

    # git
    gs = "${git} status";

    gc = "${git} checkout";
    gcb = "${git} checkout -b";

    ga = "${git} add .";
    gap = "${git} add -p";

    gb = "${git} branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";

    gdc = "${git} diff --cached";

    gpt = ''${git} add . && ${git} commit -m "Testing" && ${git} push'';
    gpf = ''${git} add . && ${git} commit -m "Fixes" && ${git} push'';

    gph = "${git} push";
    gpu = "${git} pull";

    # gitlab
    glopen = "${pkgs.glab}/bin/glab repo view -w";

    glm = ''
      ${pkgs.ollama}/bin/ollama run llama3 "$(cat ~/.config/prompts/git-commit-message.txt) $(git diff)"'';
  };

  sessionVariables = {
    # https://consoledonottrack.com/
    DO_NOT_TRACK = 1;
    HOMEBREW_NO_ANALYTICS = 1;

    AWS_PAGER = "";
    AWS_CA_BUNDLE = config.age.secrets.certs.path;
    REQUESTS_CA_BUNDLE = config.age.secrets.certs.path;
    SSL_CERT_FILE = config.age.secrets.certs.path;
    #NODE_EXTRA_CA_CERTS = config.age.secrets.certs.path;
    NODE_EXTRA_CA_CERTS = "~/.certs";
    AWS_DEFAULT_REGION = "us-east-1";
  };

  plugins = [
    {
      name = "zsh-defer";
      src = pkgs.fetchFromGitHub {
        owner = "romkatv";
        repo = "zsh-defer";
        rev = "master";
        sha256 = "sha256-MFlvAnPCknSgkW3RFA8pfxMZZS/JbyF3aMsJj9uHHVU=";
      };
    }
  ];
}
