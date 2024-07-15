HOSTNAME := $(shell hostname -s)
UNAME := $(shell uname)

.PHONY: switch
switch:
ifeq ($(UNAME), Darwin)
	@nix build ".#darwinConfigurations.${HOSTNAME}.system" --extra-experimental-features "nix-command flakes"
	@./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${HOSTNAME}"
else
	@sudo nixos-rebuild switch --flake ".#${HOSTNAME}"
endif

.PHONY: update
update:
	@nix flake update

.PHONY: fmt
fmt:
	@nix run nixpkgs#nixfmt-classic .

.PHONY: lint
lint:
	@nix run nixpkgs#statix check .

.PHONY: check
check:
	@nix run "github:DeterminateSystems/flake-checker"

.PHONY: validate
validate:
	@make fmt
	@make lint
	@make check