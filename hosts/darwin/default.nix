{ pkgs, ... }: {
  services = { nix-daemon.enable = true; };

  nix.settings.experimental-features = "nix-command flakes";
  security.pam.enableSudoTouchIdAuth = true;

  environment.shells = with pkgs; [ bash zsh ];
  # Creates /etc/zshrc that load the nix-darwin environment
  programs.zsh.enable = true;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  nix = {
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
      "cloudsplaining"
      "oidc-kubelogin"
      "terraform-docs"
      "doggo"
      "checkov"
      "qemu"
      {
       name = "libvirt";
       restart_service = "changed";
       start_service = true;
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
    ];
  };

  system = {
    stateVersion = 4;

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
}
