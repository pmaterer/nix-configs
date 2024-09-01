{
  nvim-tree = {
    enable = true;
    openOnSetupFile = true;
    autoReloadOnWrite = true;
  };
  treesitter.enable = true;
  conform-nvim.enable = true;
  neogit.enable = true;
  fzf-lua.enable = true;

  lsp-format = { enable = true; };
  lsp = {
    enable = true;
    servers = {
      eslint = { enable = true; };
      html = { enable = true; };
      gopls = { enable = true; };
      terraformls = { enable = true; };
      tsserver = { enable = true; };
    };
  };
}
