# NixOS system configuration builder
{ nixpkgs, home-manager, nixvim, agenix, disko, ghostty, hosts, catppuccin, }:
{ system, hostname, email, username, }:
nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    ../hosts/${hostname}
    agenix.nixosModules.default
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
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
    hosts.nixosModule
    { networking.stevenBlackHosts.enable = true; }
    disko.nixosModules.disko
    { environment.systemPackages = [ ghostty.packages.${system}.default ]; }
  ];
}
