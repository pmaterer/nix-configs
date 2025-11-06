# Darwin system configuration builder
{
  nixpkgs,
  nix-darwin,
  home-manager,
  nixvim,
  agenix,
  catppuccin,
}: {
  system,
  hostname,
  email,
  username,
}: let
  pkgs = nixpkgs.legacyPackages.${system};
in
  nix-darwin.lib.darwinSystem {
    inherit system;
    modules = [
      ../hosts/darwin
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
            defaultEmail = email;
          };
          users.${username} = import ../home;
        };
      }
      {
        users.users.${username} = {
          home = "/Users/${username}";
          shell = pkgs.zsh;
        };
      }
      {nixpkgs = {hostPlatform = system;};}
    ];
  }
