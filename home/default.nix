{ pkgs, config, nixvim, agenix, defaultEmail, ... }: {
  imports = [ nixvim.homeManagerModules.nixvim ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  # secrets
  age = {
    identityPaths = [ "${config.home.homeDirectory}/.ssh/nix-configs" ];
    secrets.environment.file = ../secrets/environment.age;
    secrets.certs.file = ../secrets/certs.age;
  };

  home = {
    stateVersion = "23.05";
    preferXdgDirectories = true;
    sessionVariables = { NIX_MANAGED = "true"; };

    file.".npmrc".text = ''
      prefix=~/.npm
    '';

    packages = with pkgs;
      [
        # admin tools
        coreutils
        neofetch
        colordiff
        ripgrep
        tree
        yq
        gnutar
        gnumake
        unzip

        dnsmasq

        ffmpeg

        agenix.packages.${system}.default

        # etc
        imagemagick
        nerdfonts
        cowsay
        fortune
        lolcat
        gmailctl
        graphviz

        # fonts
        monaspace

        # git
        ghorg
        pre-commit
        glab

        # development
        shellcheck
        python3
        nodejs_latest
        yarn
        asdf-vm

        # networking
        ipcalc
        curl

        #nix
        nixfmt-classic
        nil # nix lsp

        # devops
        tflint
        terragrunt
        terrascan

        # vms
        packer

        # cloud
        aws-sso-cli
        awscli

        # k8s
        kubectl
        kubernetes-helm
        kubectx
        argo
        argocd
        eks-node-viewer

        # charmbracelet
        glow
        vhs
        pop
        gum
        skate
      ] ++ (if pkgs.stdenv.isLinux then
        with pkgs; [
          terraform-docs
          vagrant
          spotify-player
          iw
          qemu
          OVMF
          libvirt
          virt-viewer
          virt-manager
          pciutils
          glxinfo
          lshw

          libxslt
        ]
      else
        [ ]);
  };
  xdg = {
    enable = true;

    configFile."spotify-player/app.toml".text = ''
      client_id = "3294e1e273f442519e5abf3b7bafed99"
    '';
  };

  programs = {
    home-manager.enable = true;

    alacritty = import ./alacritty;
    tmux = import ./tmux { inherit pkgs; };
    zsh = import ./zsh { inherit pkgs config; };
    git = import ./git { inherit pkgs defaultEmail; };
    vscode = import ./vscode { inherit pkgs; };
    nixvim = import ./neovim;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gh = { enable = true; };
    go = {
      enable = true;
      goBin = ".local/bin.go";
    };
    bat = {
      enable = true;
      config = {
        paging = "never";
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
    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      # https://docs.atuin.sh/configuration/config/
      settings = {
        enter_accept = false;
        dotfiles.enabled = false;
      };
    };
    jq.enable = true;
    htop.enable = true;
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
    pyenv.enable = true;
    fd = { enable = true; };
  };
}
