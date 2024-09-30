{ pkgs }:
{
  nvim-autopairs.enable = true;

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

  spectre = {
    enable = true;
    findPackage = pkgs.ripgrep;
    replacePackage = pkgs.gnused;
    settings = {
      replace = {
        cmd = "${pkgs.gnused}/bin/sed";
      };
    };
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
      bashls = { enable = true; };
      docker-compose-language-service = { enable = true; };
      dockerls = { enable = true; };
      eslint = { enable = true; };
      gopls = { enable = true; };
      helm-ls = { enable = true; };
      html = { enable = true; };
      lua-ls = { enable = true; };
      nixd = { enable = true; };
      pylsp = { enable = true; };
      tsserver = { enable = true; };
      terraformls = { enable = true; };
      yamlls = { enable = true; };
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

  # Autocomplete
  cmp = {
    enable = true;
    settings = {
      autoEnableSources = true;
      experimental = { ghost_text = true; };
      sources = map (name: { inherit name; }) [
        "nvim_lsp"
        "nvim_lua"
        "git"
        "emoji"
        "path"
        "buffer"
        "luasnip"
        "cmdline"
      ];
      mapping = {
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<CR>" = "cmp.mapping.confirm({ select = true})";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
      };
      snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
    };
  };
  luasnip.enable = true;
  friendly-snippets.enable = true;

  lint.enable = true;
  conform-nvim.enable = true;
}
