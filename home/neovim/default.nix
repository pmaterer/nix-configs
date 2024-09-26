# https://nix-community.github.io/nixvim/
let
  settings = import ./settings.nix;
  keymaps = import ./keymaps.nix;
  colorschemes = import ./colorschemes.nix;
  autocmd = import ./autocmd.nix;
  plugins = import ./plugins;
in {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  # package = pkgs.neovim-nightly;

  globals.mapleader = ",";
  clipboard.register = "unnamedplus";

  opts = settings;
  keymaps = keymaps;
  colorschemes = colorschemes;
  autoCmd = autocmd;

  plugins = plugins;
}
