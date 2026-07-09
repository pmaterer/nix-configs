{ pkgs, config, ... }: {
  security.pam.services.sudo_local.touchIdAuth = true;

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

    taps = [
      "ggpeti/rmrec"
      "homebrew/services"
      "int128/kubelogin"
      "FelixKratz/formulae"
      "minamijoyo/hcledit"
    ];
    brews = [
      "glab"
      "int128/kubelogin/oidc-kubelogin"
      "doggo"
      "qemu"
      # "spotify_player"
      "opa"
      "terragrunt"
      "golangci-lint"
      "postgresql"
      "postgresql@17"
      {
        name = "libvirt";
        start_service = true;
        restart_service = true;
      }
      "llm"
      "felixkratz/formulae/sketchybar"
      "kind"
      "reattach-to-user-namespace"
      "grc"
      "aws-sso-cli"
      "kubeconform"
      "colima"
      "libpq"
      "minamijoyo/hcledit/hcledit"
    ];
    casks = [
      "claude-code"
      "bitwarden"
      #"docker"
      "firefox"
      "maccy"
      "postgres-app"
      "rectangle"
      "spotify"
      "visual-studio-code"
      "wireshark-app"
      "xscreensaver"
      "notion"
      "stats"
      "vagrant"
      "gimp"
      "wezterm"
      "ghostty"
      "flashspace"
      "inkscape"
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
        # Performance improvements
        NSWindowResizeTime = 1.0e-3;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        PMPrintingExpandedStateForPrint = true;

        AppleInterfaceStyle = "Dark";
        _HIHideMenuBar = true;

        # Disable automatic text replacements
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;

        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Always";

        ApplePressAndHoldEnabled = false;
        KeyRepeat = 1;
        InitialKeyRepeat = 14;

        NSAutomaticWindowAnimationsEnabled = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      screencapture.location = "/Users/${config.system.primaryUser}/screenshots";
      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
        FXDefaultSearchScope = "SCcf";
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
  #
}
