{ pkgs, ... }: {
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  security.pam.enableSudoTouchIdAuth = true;

  environment.shells = with pkgs; [ bash zsh ];
  # Creates /etc/zshrc that load the nix-darwin environment
  programs.zsh.enable = true;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.overlays = [ neovim-nightly-overlay.overlay ];

  nix = {
    gc = {
      automatic = true;
      interval.Day = 7;
    };

  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    taps = [ "int128/kubelogin" "homebrew/cask-fonts" ];
    brews = [ "oidc-kubelogin" "terraform-docs" "doggo" ];
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
    ];
  };

  system = {
    defaults = {
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

        InitialKeyRepeat = 14;
        KeyRepeat = 1;
      };
      screencapture.location = "${builtins.getEnv "HOME"}/screenshots";
      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
      };
      dock = {
        autohide = true;
        orientation = "bottom";
        showhidden = true;
        mineffect = "genie";
        launchanim = true;
        show-process-indicators = true;
        tilesize = 48;
        static-only = true;
        mru-spaces = false;
        show-recents = false;
      };

    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  # Used for backwards compatibility. Please read the changelog
  # before changing: `darwin-rebuild changelog`.
  system.stateVersion = 4;
}
