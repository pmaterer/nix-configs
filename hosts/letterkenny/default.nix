{ pkgs, config, lib, ... }: {

  imports = [ ./hardware-configuration.nix ./libvirt.nix ./disks.nix ];

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

  services = {
    displayManager = {
      defaultSession = "plasma";
      cosmic-greeter.enable = true;
    };
    desktopManager.cosmic.enable = true;

    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "caps:escape";
      };

      displayManager = { lightdm.enable = true; };

      desktopManager = { plasma5.enable = true; };

      videoDrivers = [ "nvidia" ];
    };
    libinput.enable = true;
    openssh.enable = true;
    ntp.enable = true;
    blueman.enable = true;
  };

  programs.zsh.enable = true;

  users.users.patrick = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
    packages = with pkgs; [ firefox bitwarden-desktop ];
    shell = pkgs.zsh;
  };

  virtualisation = { docker.enable = true; };

  system.stateVersion = "24.05";
}
