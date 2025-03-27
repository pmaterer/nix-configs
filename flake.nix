{
  description = "This place is not a place of honor... no highly esteemed deed is commemorated here... nothing valued is here.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay/458f080e8f7005a9c464101100831f066b21a97e";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hosts = {url = "github:StevenBlack/hosts";};
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {url = "github:ghostty-org/ghostty";};
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nixvim,
    neovim-nightly,
    hosts,
    agenix,
    disko,
    ghostty,
  }: let
    mkDarwinConfig = {
      system,
      hostname,
      email,
      username,
    }: let
      #overlays = [ neovim-nightly-overlay.overlays.default ];
      pkgs = nixpkgs.legacyPackages.${system};
    in
      nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          # (import ./hosts/darwin { inherit pkgs system; })
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
              ];
              extraSpecialArgs = {
                inherit nixvim agenix system;
                defaultEmail = "patrick.materer@socure.com";
                #neovimNightly = neovim-nightly.packages.${system}.default;
              };
              users.${username} = import ./home;
            };
          }
          {
            users.users.${username} = {
              home = "/Users/${username}";
              shell = pkgs.zsh;
            };
          }
          {
            nixpkgs = {
              hostPlatform = system;
              #overlays = overlays;
            };
          }
        ];
      };
  in {
    # $WORK
    darwinConfigurations.pmaterer-R6CQJ27009 = mkDarwinConfig {
      system = "aarch64-darwin";
      hostname = "Patricks-MacBook-Pro-2";
      email = "patrick.materer@socure.com";
      username = "pmaterer";
    };

    darwinConfigurations.trashcan = mkDarwinConfig {
      system = "x86_64-darwin";
      hostname = "trashcan";
      email = "patrickmaterer@gmail.com";
      username = "patrick";
    };

    nixosConfigurations.letterkenny = let
      username = "pmaterer";
      system = "x86_64-linux";
      #overlays = [ neovim-nightly.overlays.default ];
    in
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/letterkenny
          agenix.nixosModules.default
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
                #neovimNightly = neovim-nightly.packages.${system}.default;
              };
              users.${username} = import ./home;
            };
          }
          #{ nixpkgs.overlays = overlays; }
          hosts.nixosModule
          {networking.stevenBlackHosts.enable = true;}
          disko.nixosModules.disko
          {
            environment.systemPackages = [ghostty.packages.x86_64-linux.default];
          }
        ];
      };
  };
}
