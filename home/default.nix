{ pkgs, config, nixvim, defaultEmail, ... }: {
  imports = [ ./packages.nix nixvim.homeManagerModules.nixvim ];

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

    file."bin" = {
      source = ./bin;
      target = "${config.home.homeDirectory}/bin";
    };
  };

  xdg = {
    enable = true;

    configFile = {
      "spotify-player/app.toml".text = ''
        client_id = "3294e1e273f442519e5abf3b7bafed99"
      '';

      "alacritty/theme.toml".source =
        ./alacritty/themes/gruvbox_material_hard_dark.toml;
      "alacritty/themes".source = ./alacritty/themes;
    } // pkgs.lib.optionalAttrs pkgs.stdenv.isLinux {
      "libvirt/qemu.conf".text = ''
        nvram = [ "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd"]
      '';
    };
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
    #pyenv.enable = true;
    fd = { enable = true; };

    # wezterm = {
    #   enable = true;
    # };
  };
}
