# Darwin

## Install

Use [DeterminateSystems/nix-installer](https://github.com/DeterminateSystems/nix-installer).

## Upgrade Nix

```sh
sudo -i nix upgrade-nix
```

## Darwin Setup

```sh
mkdir -p ~/.config/nix && touch ~/.config/nix/flake.nix
# once code is added
git init
git add flake.nix

nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/.config/nix
```

After the initial run (in new shell):

```sh
darwin-rebuild switch --flake ~/.config/nix
```

## Links

* [Darwin Configuration Options](https://daiderd.com/nix-darwin/manual/index.html)

### Repos

* [`mitchellh/nixos-config`](https://github.com/mitchellh/nixos-config)
* [`sebastiant/dotfiles`](https://github.com/sebastiant/dotfiles)
* [`Misterio77/nix-starter-configs`](https://github.com/Misterio77/nix-starter-configs)
* [`marcusramberg/nix-config`](https://github.com/marcusramberg/nix-config)

### Blogs

* [Using Nix on macOS](https://checkoway.net/musings/nix/)
* [Package management on macOS with nix-darwin](https://davi.sh/blog/2024/01/nix-darwin/)
* [Declarative macOS Configuration Using nix-darwin And home-manager](https://xyno.space/post/nix-darwin-introduction)