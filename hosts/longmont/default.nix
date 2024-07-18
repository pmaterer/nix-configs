{ pkgs, config, lib, ... }: {

  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking = {
    hostName = "longmont";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    displayManager = {
      defaultSession = "none+i3"; # or "none+i3"
    };
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "caps:escape";
      };

      displayManager = { lightdm.enable = true; };

      desktopManager = {
        xfce.enable = true;
        lumina.enable = true;
        pantheon.enable = true;
        plasma5.enable = true;
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [ dmenu i3status i3lock ];
      };
      videoDrivers = [ "nvidia" ];
    };
    libinput.enable = true;
    openssh.enable = true;
    ntp.enable = true;
    blueman.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio.enable = true;
  };

  programs.zsh.enable = true;

  users.users.patrick = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [ firefox bitwarden-desktop ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "24.05";
}
