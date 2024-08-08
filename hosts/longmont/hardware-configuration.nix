{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  # https://thinkstation-specs.com/thinkpad/p1-gen-1/

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-intel"];
    # https://github.com/NixOS/nixos-hardware/blob/master/lenovo/thinkpad/p1/default.nix
    # Need to set Thunderbolt to "BIOS Assist Mode"
    # https://forums.lenovo.com/t5/Other-Linux-Discussions/T480-CPU-temperature-and-fan-speed-under-linux/m-p/4114832
    kernelParams = ["acpi_backlight=native"];
    extraModulePackages = [];
  };

  hardware = {
    # Quadro P1000 Mobile
    # https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/productspage/quadro/quadro-desktop/quadro-pascal-p1000-data-sheet-us-nv-704475-r1.pdf
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5150d3bd-2c1f-4d1c-ad35-66ea6052ae04";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1603-332B";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
