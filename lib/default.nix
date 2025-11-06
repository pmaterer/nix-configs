# Library functions for the Nix configuration
{
  nixpkgs,
  nix-darwin,
  home-manager,
  nixvim,
  agenix,
  disko,
  ghostty,
  hosts,
  catppuccin,
}: {
  # Darwin system configuration builder
  mkDarwinConfig = import ./mkDarwinConfig.nix {
    inherit nixpkgs nix-darwin home-manager nixvim agenix catppuccin;
  };

  # NixOS system configuration builder
  mkNixOSConfig = import ./mkNixOSConfig.nix {
    inherit nixpkgs home-manager nixvim agenix disko ghostty hosts;
  };

  # Common utilities
  utils = import ./utils.nix {inherit nixpkgs;};
}
