local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

require('packer').init({ display = { auto_clean = false } })

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'sainnhe/edge'
  use 'ChristianChiarulli/nvcode-color-schemes.vim'
  use {
    "RRethy/vim-hexokinase",

    config = function()
      require("nvim-hexokinase")
    end,
    run = "make hexokinase"
  }
  use 'sheerun/vim-polyglot'

  use {
    'akinsho/nvim-bufferline.lua',

    config = function()
      require("nvim-bufferline")
    end,
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use {
    'glepnir/galaxyline.nvim',

    config = function()
      require("nvim-galaxyline")
    end,
    requires = {
      'ryanoasis/vim-devicons',
      'kyazdani42/nvim-web-devicons'
    }
  }

  use {
    'kyazdani42/nvim-tree.lua',

    config = function()
      require("nvim-explorer")
    end,
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen"
    }
  }

  use {
    'nvim-telescope/telescope.nvim',
    
    config = function()
      require("nvim-telescope")
    end,
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim'
    }
  }
  use {
    'nvim-telescope/telescope-media-files.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
    'nvim-telescope/telescope-project.nvim',
    'nvim-telescope/telescope-dap.nvim',

    requires = { 'nvim-telescope/telescope.nvim' }
  }

  use {
    "PHSix/faster.nvim",

    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_j)", { noremap = false, silent = true })
      vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_k)", { noremap = false, silent = true })
    end
  }

  use {
    'glepnir/dashboard-nvim',

    config = function()
      require("nvim-dashboard")
    end
  }

  use {
    'neovim/nvim-lspconfig'
  }
  use {
    'kabouzeid/nvim-lspinstall',

    as = "lspinstall",
    config = function()
      require("nvim-lspinstall")
    end
  }
  use {
    'alexaandru/nvim-lspupdate',

    as = "lspupdate",
    cmd = {
      "LspUpdate"
    }
  }
  use {
    'lspcontainers/lspcontainers.nvim',

    as = "lspcontainers"
  }

  use {
    'folke/trouble.nvim',

    as = "trouble",
    config = function()
      require("trouble").setup()
    end
  }
  use {
    'folke/todo-comments.nvim',

    as = "trouble-todo-comments",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  }

  use {
    'tjdevries/nlua.nvim',

    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use {
    'tjdevries/manillua.nvim',

    as = "manillua"
  }

  use {
    "simrat39/symbols-outline.nvim",

    as = "symbols-outline",
    cmd = {
      "SymbolsOutline"
    }
  }

  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use {
    'ray-x/lsp_signature.nvim',

    as = "lsp-signature"
  }
  use 'rafamadriz/friendly-snippets'
  use {
    'glepnir/lspsaga.nvim',

    config = function()
      require("nvim-lspsaga")
    end
  }
  use { 'tzachar/compe-tabnine', run = "./install.sh", requires = { "hrsh7th/nvim-compe" } }
  use {
    'folke/lsp-colors.nvim',

    config = function()
      require("lsp-colors").setup()
    end
  }

  use 'tpope/vim-dadbod'
  use {
    'kristijanhusak/vim-dadbod-completion',
    'krisajenkins/vim-java-sql',
    'kristijanhusak/vim-dadbod-ui',

    config = function()
      require("nvim-dadbod")
    end,
    requires = { 'tpope/vim-dadbod' }
  }

  use {
    'nvim-treesitter/nvim-treesitter',

    run = ':TSUpdate',
    config = function()
      require("nvim-treesitter-config")
    end
  }
  
  use {
    "p00f/nvim-ts-rainbow",
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "andymass/vim-matchup",
    "theHamsta/crazy-node-movement",

    after = "nvim-treesitter"
  }
  use {
    "mizlan/iswap.nvim",
    
    config = function()
      require("iswap").setup {
        grey = "disable"
      }
    end
  }
  use {
    "lewis6991/spellsitter.nvim",

    config = function()
      require("spellsitter").setup {
        hl = "SpellBad",
        captures = { "comment" }
      }
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',

    branch = 'lua',
    config = function()
      require("nvim-indentline")
    end
  }

  use {
    'lewis6991/gitsigns.nvim',

    config = function()
      require("nvim-gitsigns")
    end,
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  use {
    'kkoomen/vim-doge',
    
    config = function()
      require("nvim-doge")
    end,
    run = ':call doge#install()'
  }

  use 'wakatime/vim-wakatime'

  use {
    'folke/which-key.nvim',

    as = "which-key"
  }

  use 'mfussenegger/nvim-dap'
  use {
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',

    requires = { 'mfussenegger/nvim-dap' }
  }
  use 'mfussenegger/nvim-jdtls'
  use 'mfussenegger/nvim-dap-python'
  use 'jbyuki/one-small-step-for-vimkind'

  -- Install vscode-cpptools using vimspector
  use {
    'puremourning/vimspector',
    run = "python3 install_gadget.py --enable-c",
    opt = true
  }

  use {
    "b3nj5m1n/kommentary",

    config = function()
      require('kommentary.config').configure_language('typescriptreact', {
        hook_function = function()
          require('ts_context_commentstring.internal').update_commentstring()
        end
      })
    end
  }

  use {
    'mbbill/undotree',
    
    cmd = {
      "UndotreeToggle",
      "UndotreeShow"
    }
  }

  use {
    "Pocco81/AbbrevMan.nvim",
    
    config = function()
      require("abbrev-man").setup {
        load_natural_dictionaries_at_startup = true,
        load_programming_dictionaries_at_startup = true,
        natural_dictionaries = {
          ["nt_en"] = {}
        },
        programming_dictionaries = {
          ["pr_py"] = {},
          ["pr_java"] = {},
          ["pr_lua"] = {}
        }
      }
    end
  }

  use {
    'windwp/nvim-autopairs',

    config = function()
      require("nvim-autopairs").setup()
      require("nvim-autopairs-config")
    end
  }

  use {
    'ahmedkhalf/lsp-rooter.nvim',

    config = function()
      require("lsp-rooter").setup()
    end
  }

  use {
    'monaqa/dial.nvim',

    config = function()
      require("nvim-dial")
    end
  }

  use {
    'notomo/gesture.nvim',

    config = function()
      require("nvim-mouse-gesture")
    end
  }

  use 'haringsrob/nvim_context_vt'

  use 'digitaltoad/vim-pug'

  use {
    'Pocco81/TrueZen.nvim',

    config = function()
      require("nvim-zen-mode")
    end
  }

  use 'tjdevries/colorbuddy.nvim'

  use {
    "windwp/nvim-spectre",

    config = function()
      require('spectre').setup()
    end
  }

  use {
    "phaazon/hop.nvim",

    as = "hop"
  }

  use {
    "kevinhwang91/nvim-hlslens",

    config = function()
      require("nvim-hlslens")
    end
  }

  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    cmd = {
      "MarkdownPreview",
      "MarkdownPreviewToggle"
    },
    ft = {
      "markdown",
      "pandoc.markdown",
      "rmd"
    }
  }

  use {
    "Pocco81/NoCLC.nvim",

    config = function()
      require("no-clc").setup {
        load_at_startup = true,
        cursorline = true,
        cursorcolumn = false
      }
    end
  }

  use {
    "thinca/vim-template",

    config = function()
      require("nvim-template")
    end
  }

  use "famiu/bufdelete.nvim"

  use "toritori0318/vim-redmine"

  use "antoyo/vim-licenses"

  use "tpope/vim-repeat"

  use {
    "907th/vim-auto-save",

    config = function()
      vim.g.auto_save = 1
    end
  }

  use {
    "winston0410/range-highlight.nvim",

    config = function()
      require("range-highlight").setup()
    end,
    requires = {
      "winston0410/cmd-parser.nvim"
    }
  }

  use {
    "steelsojka/headwind.nvim",

    config = function()
      require("headwind").setup()
    end
  }

  use {
    "akinsho/nvim-toggleterm.lua",

    config = function()
      require("toggleterm").setup {
        open_mapping = [[<C-t>]]
      }
    end
  }
end, {
  profile = {
    enable = true
  }
})

