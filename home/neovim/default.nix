# https://nix-community.github.io/nixvim/
{ pkgs }:
let
  opts = import ./opts.nix;
  keymaps = import ./keymaps.nix;
  autoCmd = import ./autocmd.nix;
  plugins = import ./plugins { inherit pkgs; };
in {
  inherit keymaps plugins autoCmd opts;
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;

  globals.mapleader = ",";
  clipboard.register = "unnamedplus";

  extraPlugins = let
    spaceduck = pkgs.vimUtils.buildVimPlugin {
      name = "spaceduck";
      src = pkgs.fetchFromGitHub {
        owner = "pineapplegiant";
        repo = "spaceduck";
        rev = "main";
        sha256 = "sha256-lE8y9BA2a4y0B6O3+NyOS7numoltmzhArgwTAner2fE=";
      };
    };
  in [ spaceduck ];

  #colorscheme = "spaceduck";
  colorschemes = { melange.enable = true; };

  extraPackages = with pkgs; [ gnused ];
}
