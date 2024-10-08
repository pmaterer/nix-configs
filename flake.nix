{
  description =
    "This place is not a place of honor... no highly esteemed deed is commemorated here... nothing valued is here.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hosts = { url = "github:StevenBlack/hosts"; };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, nixvim
    , neovim-nightly-overlay, hosts, agenix, cosmic, catppuccin }: {
      # work
      darwinConfigurations.Patricks-MacBook-Pro-2 = let
        username = "pmaterer";
        system = "aarch64-darwin";
        overlays = [ neovim-nightly-overlay.overlays.default ];
      in nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./hosts/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              verbose = true;
              backupFileExtension = "hm-backup";
              sharedModules = [
                agenix.homeManagerModules.age # add age config
                catppuccin.homeManagerModules.catppuccin
              ];
              extraSpecialArgs = {
                inherit nixvim agenix system;
                defaultEmail = "patrick.materer@socure.com";
              };
              users.${username} = import ./home;
            };
          }
          {
            users.users.${username} = {
              home = "/Users/${username}";
              shell = nixpkgs.zsh;
            };
          }
          { nixpkgs.overlays = overlays; }
        ];
      };

      nixosConfigurations.longmont = let
        username = "patrick";
        system = "x86_64-linux";
        overlays = [ neovim-nightly-overlay.overlays.default ];
      in nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/longmont
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-backup";
              sharedModules = [
                agenix.homeManagerModules.age # add age config
              ];
              extraSpecialArgs = {
                inherit nixvim agenix system;
                defaultEmail = "patrickmaterer@gmail.com";
              };
              users.${username} = import ./home;
            };
          }
          { nixpkgs.overlays = overlays; }
          hosts.nixosModule
          { networking.stevenBlackHosts.enable = true; }
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [
                "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
              ];
            };
          }
          cosmic.nixosModules.default
        ];
      };
    };
}
