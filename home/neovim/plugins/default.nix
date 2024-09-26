{
  nvim-autopairs.enable = true;

  # https://github.com/norcalli/nvim-colorizer.lua
  nvim-colorizer = {
    enable = true;
    userDefaultOptions.names = false;
  };

  floaterm = {
    enable = true;
    width = 0.8;
    height = 0.8;
    keymaps.toggle = "<leader>,";
  };

  nvim-tree = {
    enable = true;
    openOnSetupFile = true;
    autoReloadOnWrite = true;
  };

  lualine.enable = true;

  telescope = {
    enable = true;
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
      "<leader>b" = "buffers";
      "<leader>fh" = "help_tags";
      "<leader>fd" = "diagnostics";

      # fzf-like bindings
      "<C-p>" = "git_files";
      "<leader>p" = "oldfiles";
      "<C-f>" = "live_grep";
    };
    settings.defaults = {
      file_ignore_patterns = [ "^.git/" ];
      set_env.COLORTERM = "truecolor";
    };
  };

  # LSP

  # https://github.com/lukas-reineke/lsp-format.nvim
  lsp-format.enable = true;
  # https://git.sr.ht/~whynothugo/lsp_lines.nvim
  lsp-lines.enable = true;
  lsp = {
    enable = true;
    servers = {
      # web
      eslint = { enable = true; };
      html = { enable = true; };
      tsserver = { enable = true; };

      gopls = { enable = true; };

      terraformls = { enable = true; };
    };
    keymaps = {
      silent = true;
      diagnostic = {
        # navigation
        "<leader>k" = "goto_prev";
        "<leader>j" = "goto_next";
      };
      lspBuf = {
        gd = "definition";
        gD = "references";
        gt = "type_definition";
        gi = "implementation";
        K = "hover";
        "<F2>" = "rename";
      };
    };
  };

  # autocomplete
  cmp = {
    enable = true;
    settings = {
      autoEnableSources = true;
      experimental = { ghost_text = true; };
      performance = {
        debounce = 60;
        fetchingTimeout = 200;
        maxViewEntries = 30;
      };
      sources = [
        { name = "git"; }
        { name = "nvim_lsp"; }
        { name = "emoji"; }
        {
          name = "path";
          keywordLength = 3;
        }
      ];
      window = {
        completion = { border = "solid"; };
        documentation = { border = "solid"; };
      };
      mapping = {
        "<C-Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<C-j>" = "cmp.mapping.select_next_item()";
        "<C-k>" = "cmp.mapping.select_prev_item()";
        "<C-e>" = "cmp.mapping.abort()";
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-CR>" = "cmp.mapping.confirm({select = true})";
        "<S-CR>" =
          "cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})";
      };
    };
  };
  cmp-emoji.enable = true;
  cmp-nvim-lsp.enable = true;
  cmp-buffer.enable = true;
  cmp-path.enable = true;
  cmp-cmdline.enable = true;
}
