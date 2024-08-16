# https://nix-community.github.io/nixvim/
{
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  # package = pkgs.neovim-nightly;

  globals.mapleader = ","; clipboard.register = "unnamedplus";
  opts = let
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
  };

  keymaps = let
    defaultOptions = {
      silent = true;
      noremap = true;
    };
  in [
    # delete line
    {
      mode = "n";
      key = "<C-d>";
      action = "dd";
      options = defaultOptions;
    }
    {
      mode = "i";
      key = "<C-d>";
      action = "<esc>ddi";
      options = defaultOptions;
    }

    # uppercase word
    {
      mode = "n";
      key = "<C-u>";
      action = "viwU";
      options = defaultOptions;
    }
    {
      mode = "i";
      key = "<C-u>";
      action = "<esc>viwUi";
      options = defaultOptions;
    }

    # save/quit
    {
      mode = "n";
      key = "<C-w>";
      action = ":qa!<cr>";
      options = defaultOptions;
    }
    {
      mode = "n";
      key = "<C-s>";
      action = ":w<cr>";
      options = defaultOptions;
    }

    # disable arrow keys
    {
      mode = "n";
      key = "<up>";
      action = "<nop>";
      options = defaultOptions;
    }
    {
      mode = "n";
      key = "<right>";
      action = "<nop>";
      options = defaultOptions;
    }
    {
      mode = "n";
      key = "<down>";
      action = "<nop>";
      options = defaultOptions;
    }
    {
      mode = "n";
      key = "<left>";
      action = "<nop>";
      options = defaultOptions;
    }

    # window switching
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = defaultOptions;
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = defaultOptions;
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = defaultOptions;
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = defaultOptions;
    }

    # quote word
    {
      mode = "n";
      key = "<leader>\"'";
      action = ''viw<esc>a"<esc>bi"<esc>lel'';
      options = defaultOptions;
    }
    {
      mode = "n";
      key = "<leader>'";
      action = "viw<esc>a'<esc>bi'<esc>lel";
      options = defaultOptions;
    }

    {
      mode = "v";
      key = "<leader>\"'";
      action = ''<esc>a"<esc>`<i"<esc>'';
      options = defaultOptions;
    }
    {
      mode = "v";
      key = "<leader>'";
      action = "<esc>a'<esc>`<i'<esc>";
      options = defaultOptions;
    }

    # increment/decrement
    {
      mode = "n";
      key = "+";
      action = "<C-a>";
      options = defaultOptions;
    }
    {
      mode = "n";
      key = "-";
      action = "<C-x>";
      options = defaultOptions;
    }

    # format json
    {
      mode = "n";
      key = "<leader>fj";
      action = "%!jq .";
      options = defaultOptions;
    }

    # file explorer
    {
      key = "<C-n>";
      action = "<CMD>NvimTreeToggle<CR>";
      options = defaultOptions;
    }
    {
      key = "<leader>r";
      action = "<CMD>NvimTreeRefresh<CR>";
      options = defaultOptions;
    }
    {
      key = "<leader>n";
      action = "<CMD>NvimTreeFindFile<CR>";
      options = defaultOptions;
    }
  ];

  colorschemes = { 
    base16 = {
      enable = true;
      colorscheme = "dracula";
    };
  };


  plugins = {
    nvim-tree = {
      enable = true;
      openOnSetupFile = true;
      autoReloadOnWrite = true;
    };
    treesitter.enable = true;
    conform-nvim.enable = true;
    neogit.enable = true;
    fzf-lua.enable = true;
  };
}
