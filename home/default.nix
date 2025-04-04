{
  pkgs,
  config,
  nixvim,
  defaultEmail,
  ...
}: {
  imports = [./packages.nix nixvim.homeManagerModules.nixvim];

  # secrets
  age = {
    identityPaths = ["${config.home.homeDirectory}/.ssh/nix-configs"];
    secrets.environment.file = ../secrets/environment.age;
    secrets.certs.file = ../secrets/certs.age;
    secrets.tailscale.file = ../secrets/tailscale.age;
  };

  home = {
    stateVersion = "23.05";
    preferXdgDirectories = true;
    sessionVariables = {NIX_MANAGED = "true";};

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

    configFile =
      {
        "spotify-player/app.toml".text = ''
          client_id = "3294e1e273f442519e5abf3b7bafed99"
        '';
        "alacritty/theme.toml".source = ./alacritty/melange_dark.toml;
        "ghostty/config".text = ''
          theme = duckbones


          # vertical split (C-f |)
          keybind = super+d=text:\x06|
          # horizontal split (C-f -)
          keybind = super+shift+d=text:\x06-

          # move right (M-RightArrow)
          keybind = super+right=text:\x06\x1b\x5b\x43
          keybind = super+up=text:\x06\x1b\x5b\x41
          keybind = super+left=text:\x06\x1b\x5b\x44
          keybind = super+down=text:\x06\x1b\x5b\x42

          # maximize pane
          keybind = super+enter=text:\x06\x7a

          font-family = "IosevkaTerm Nerd Font Mono"

          background-opacity = 0.9

          title = ""

          macos-titlebar-style = hidden
          window-decoration = false
        '';
      }
      // pkgs.lib.optionalAttrs pkgs.stdenv.isLinux {
        "libvirt/qemu.conf".text = ''
          nvram = [ "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd"]
        '';
      };
  };

  programs = {
    home-manager.enable = true;

    alacritty = import ./alacritty;
    tmux = import ./tmux {inherit pkgs;};
    zsh = import ./zsh {inherit pkgs config;};
    git = import ./git {inherit pkgs defaultEmail;};
    vscode = import ./vscode {inherit pkgs;};
    nixvim = import ./neovim {inherit pkgs;};
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gh = {enable = true;};
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
      settings = {add_newline = false;};
    };
    eza = {
      enable = true;
      icons = "auto";
      git = true;
    };
    atuin = {
      enable = false;
      flags = ["--disable-up-arrow"];
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
    fd = {enable = true;};

    # wezterm = {
    #   enable = true;
    # };
  };
}
