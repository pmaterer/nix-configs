# NixOS

## Setup

My machine, `letterkenny`, is a [ThinkPad P1 Gen 1](https://thinkstation-specs.com/thinkpad/p1-gen-1/).

The following steps describe how to setup the machine with NixOS.

Boot from the NixOS minimal image.

Connect to WiFi:

```sh
wpa_passphrase <SSID> <passphrase> | sudo tee /etc/wpa_supplicant.conf

# Replace wlp0s20f3 with relevant wireless device
sudo wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlp0s20f3

sudo dhcpcd

# To confirm internet works
ping -c 3 google.com
```

```
nix-shell -p git
git clone https://github.com/pmaterer/nix-configs.git
cd nix-configs


# Run disko
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disk/latest -- --mode disko hosts/letterkenny/disks.nix

sudo nixos-install --flake .#letterkenny
```

Now set the root user password:

```sh
sudo su -
passwd
```

From another machine, with Nix installed:

```sh
nix run github:nix-community/nixos-anywhere -- --build-on-remote --flake '.#letterkenny' root@<ip addr>
```

Install using `disko`:

```sh
sudo nix --extra-experimental-features 'flakes nix-command' run github:nix-community/disko#disko-install -- --flake github:pmaterer/nix-configs#letterkenny --write-efi-boot-entries --disk main '/dev/disk/by-id/nvme-SAMSUNG_MZVLB1T0HALR-000L7_S3TPNX0K921497'
```
