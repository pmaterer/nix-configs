{
  description = "This place is not a place of honor... no highly esteemed deed is commemorated here... nothing valued is here.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    hosts = {url = "github:StevenBlack/hosts";};
    agenix = {
      url = "github:ryantm/agenix";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {url = "github:ghostty-org/ghostty";};
    catppuccin = {
      url = "github:catppuccin/nix/v1.0.2";
      # Note: catppuccin doesn't have nixpkgs input, so no follows needed
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nixvim,
    hosts,
    agenix,
    disko,
    ghostty,
    catppuccin,
  }: let
    # Import our library functions
    lib = import ./lib {
      inherit
        nixpkgs
        nix-darwin
        home-manager
        nixvim
        agenix
        disko
        ghostty
        hosts
        catppuccin
        ;
    };
  in {
    # $WORK
    darwinConfigurations.pmaterer-R6CQJ27009 = lib.mkDarwinConfig {
      system = "aarch64-darwin";
      hostname = "Patricks-MacBook-Pro-2";
      email = "patrick.materer@socure.com";
      username = "pmaterer";
    };

    darwinConfigurations.trashcan = lib.mkDarwinConfig {
      system = "x86_64-darwin";
      hostname = "trashcan";
      email = "patrickmaterer@gmail.com";
      username = "patrick";
    };

    nixosConfigurations.letterkenny = lib.mkNixOSConfig {
      system = "x86_64-linux";
      hostname = "letterkenny";
      email = "patrickmaterer@gmail.com";
      username = "pmaterer";
    };
  };
}
