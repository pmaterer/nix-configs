{
  description =
    "This place is not a place of honor... no highly esteemed deed is commemorated here... nothing valued is here.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hosts = { url = "github:StevenBlack/hosts"; };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, nixvim
    , neovim-nightly-overlay, hosts, catppuccin }: {

      # work
      darwinConfigurations.Patricks-MacBook-Pro = let
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
              sharedModules = [ catppuccin.homeManagerModules.catppuccin ];
              extraSpecialArgs = {
                inherit nixvim;
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
              sharedModules = [ catppuccin.homeManagerModules.catppuccin ];
              extraSpecialArgs = {
                inherit nixvim;
                defaultEmail = "patrickmaterer@gmail.com";
              };
              users.${username} = import ./home;
            };
          }
          { nixpkgs.overlays = overlays; }
          hosts.nixosModule
          { networking.stevenBlackHosts.enable = true; }
        ];
      };
    };
}
