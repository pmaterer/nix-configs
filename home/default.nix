{ pkgs, config, nixvim, ... }: {

  home = {
    stateVersion = "23.05";
    preferXdgDirectories = true;
    sessionVariables = { NIX_MANAGED = "true"; };

    file.".npmrc".text = ''
      prefix=~/.npm
    '';

    packages = with pkgs; [
      coreutils
      neofetch
      bat
      colordiff
      direnv
      fzf
      ghorg
      gnugrep
      ipcalc
      pre-commit
      ripgrep
      shellcheck
      tree
      yq
      imagemagick
      curl
      gnutar

      glow

      nerdfonts

      python3

      cowsay
      fortune
      lolcat

      nixfmt-classic
      nil # nix lsp
      devenv

      # terraform-docs (installed via brew)
      tflint
      terragrunt
      terrascan

      gmailctl

      # cloud
      aws-sso-cli
      awscli

      # k8s
      kubernetes-helm
      kubectx
      argo
      argocd
      eks-node-viewer

      # nodejs
      nodejs_latest
      yarn

      # gitlab
      glab

      # podman-desktop

      graphviz

      # https://github.com/charmbracelet
      glow
      vhs
      pop
      gum
      skate

      gh
    ];
  };

  imports = [ nixvim.homeManagerModules.nixvim ];

  xdg = {
    enable = true;
    configFile."alacritty/theme.toml".source = ./alacritty/theme.toml;
  };

  programs = {
    home-manager.enable = true;
    alacritty = import ./alacritty { inherit pkgs; };
    tmux = import ./tmux { inherit pkgs; };
    zsh = import ./zsh { inherit pkgs config; };
    git = import ./git { inherit pkgs; };
    vscode = import ./vscode { inherit pkgs; };
    nixvim = import ./neovim { inherit pkgs; };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    go = {
      enable = true;
      goBin = ".local/bin.go";
    };
    bat = {
      enable = true;
      config = {
        paging = "never";
        theme = "ansi";
        style = "plain";
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      settings = { add_newline = false; };
    };
    eza = {
      enable = true;
      icons = true;
      git = true;
    };
    jq.enable = true;
    htop.enable = true;
    dircolors.enable = true;
    pyenv.enable = true;
  };
}
