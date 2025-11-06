# Common utility functions
{ nixpkgs }: {
  # Helper to get system packages
  getSystemPackages = system: nixpkgs.legacyPackages.${system};

  # Helper to check if system is Darwin
  isDarwin = system: nixpkgs.lib.hasSuffix "darwin" system;

  # Helper to check if system is Linux
  isLinux = system: nixpkgs.lib.hasSuffix "linux" system;

  # Helper to conditionally include modules based on system
  forSystem = system: darwinModules: linuxModules:
    if (nixpkgs.lib.hasSuffix "darwin" system) then
      darwinModules
    else
      linuxModules;

  # Helper to merge configurations
  mergeConfigs = configs: nixpkgs.lib.mkMerge configs;
}
