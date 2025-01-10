{ pkgs, ... }: {
  services = { nix-daemon.enable = true; };

  security.pam.enableSudoTouchIdAuth = true;

  environment.shells = with pkgs; [ bash zsh ];
  # Creates /etc/zshrc that load the nix-darwin environment
  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "root" "pmaterer" ];
    };
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--max-free 10G";
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    taps = [ "ggpeti/rmrec" "homebrew/services" "int128/kubelogin" ];
    brews = [
      "oidc-kubelogin"
      "terraform-docs"
      "doggo"
      "qemu"
      # "spotify_player"
      "opa"
      "terragrunt"
      "golangci-lint"
      "gnu-sed" # needed by nvim-spectre
      "postgresql@17"
      {
        name = "libvirt";
        start_service = true;
        restart_service = true;
      }
    ];
    casks = [
      "alacritty"
      "bitwarden"
      "docker"
      "firefox"
      "maccy"
      "postgres-unofficial"
      "rectangle"
      "spotify"
      "visual-studio-code"
      "wireshark"
      "xscreensaver"
      "notion"
      "stats"
      "vagrant"
      "gimp"
      "wezterm"
    ];
  };

  system = {
    stateVersion = 4;

    defaults = {
      dock = {
        autohide = true;
        orientation = "right";
        showhidden = true;
        mineffect = "genie";
        launchanim = true;
        show-process-indicators = true;
        tilesize = 48;
        static-only = true;
        mru-spaces = false;
        show-recents = false;
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        _HIHideMenuBar = true;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;

        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Always";

        KeyRepeat = 1;
        InitialKeyRepeat = 14;
      };

      screencapture.location = "${builtins.getEnv "HOME"}/screenshots";
      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
