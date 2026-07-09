let
  tabSize = 2;
  encodingStandard = "utf-8";
in {
  cmdheight = 2;

  encoding = encodingStandard;
  fileencoding = encodingStandard;

  filetype = "on";
  syntax = "on";

  smartcase = true;
  ignorecase = true;
  smartindent = true;

  softtabstop = tabSize;
  tabstop = tabSize;

  termguicolors = true;
  wrap = true;

  splitbelow = true;
  splitright = true;

  swapfile = false;

  pumheight = 10;
  ruler = true;

  expandtab = true;

  number = true;
  relativenumber = true;

  shiftround = true;
  shiftwidth = tabSize;
  signcolumn = "yes";

  foldenable = true;
  foldmethod = "expr";
  foldexpr = "nvim_treesitter#foldexpr()";
  foldlevel = 99; # Ensure that all folds are open by default
  foldnestmax = 3;
}
