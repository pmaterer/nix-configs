{ pkgs, config, lib, ... }: {

  imports =
    [ ./hardware-configuration.nix ./libvirt.nix ./disks.nix ./tailscale.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking = {
    hostName = "letterkenny";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  age = {
    identityPaths = [ "/home/pmaterer/.ssh/nix-configs" ];
    secrets.tailscale.file = ../../secrets/tailscale.age;
  };

  services = {
    displayManager = { defaultSession = "plasma"; };

    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "caps:escape";
      };

      displayManager = { lightdm.enable = true; };

      desktopManager = {
        plasma5.enable = true;
        enlightenment.enable = true;
      };

      videoDrivers = [ "nvidia" ];
    };
    libinput.enable = true;
    openssh.enable = true;
    ntp.enable = true;
    blueman.enable = true;
    tailscale = { enable = true; };
  };

  programs = {
    zsh.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ libgcc glibc ];
    };
  };

  users.users.pmaterer = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
    packages = with pkgs; [ firefox bitwarden-desktop ];
    shell = pkgs.zsh;
  };

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
  };
  users.extraGroups.vboxusers.members = [ "pmaterer" ];

  system.stateVersion = "24.05";
}
