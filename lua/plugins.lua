local execute = vim.api.nvim_command
local fn = vim.fn

vim.api.nvim_set_keymap('i', '<expr><TAB>', 'pumvisible() ? \"\\<C-n>\" : \"\\<TAB>\"', { noremap = true, silent = true })
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
  use 'norcalli/nvim-colorizer.lua'
  use 'sheerun/vim-polyglot'

  use { 'akinsho/nvim-bufferline.lua', requires = { 'kyazdani42/nvim-web-devicons' } }

  use {
    'glepnir/galaxyline.nvim',
    requires = { { 'ryanoasis/vim-devicons' }, { 'kyazdani42/nvim-web-devicons' } },
    config = function()
      require("nvim-galaxyline")
    end
  }

  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }

  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use {
    'nvim-telescope/telescope-media-files.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
    'nvim-telescope/telescope-project.nvim',
    requires = { 'nvim-telescope/telescope.nvim' }
  }

  use 'glepnir/dashboard-nvim'

  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  use 'alexaandru/nvim-lspupdate'

  use {
    'folke/trouble.nvim',
    config = function()
      require("trouble").setup()
    end
  }
  use {
    'folke/todo-comments.nvim',
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

  use 'tjdevries/manillua.nvim'

  use 'mfussenegger/nvim-jdtls'

  use { "simrat39/symbols-outline.nvim", cmd = { "SymbolsOutline" } }

  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'
  use { 'glepnir/lspsaga.nvim', cmd = { "Lspsaga" } }
  use 'kristijanhusak/vim-dadbod-completion'
  use { 'tzachar/compe-tabnine', run = "./install.sh", requires = { "hrsh7th/nvim-compe" } }
  use {
    'kosayoda/nvim-lightbulb',
    config = function()
      require("nvim-lightbulb-config")
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      { "p00f/nvim-ts-rainbow" }, { "windwp/nvim-ts-autotag" }, { "JoosepAlviste/nvim-ts-context-commentstring" }, { "andymass/vim-matchup" }
    },
    config = function()
      require("nvim-treesitter-config")
    end
  }

  use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }

  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'f-person/git-blame.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  use { 'kkoomen/vim-doge', run = ':call doge#install()' }

  use 'wakatime/vim-wakatime'

  use 'folke/which-key.nvim'

  use 'mfussenegger/nvim-dap'

  use {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup()
    end
  }

  use {
    'ahmedkhalf/lsp-rooter.nvim',
    config = function()
      require("lsp-rooter").setup()
    end
  }

  use 'monaqa/dial.nvim'

  use 'tpope/vim-endwise'

  use 'notomo/gesture.nvim'

  use 'haringsrob/nvim_context_vt'

  use 'digitaltoad/vim-pug'

  use 'Pocco81/TrueZen.nvim'

  use 'tjdevries/colorbuddy.nvim'

  use {
    "windwp/nvim-spectre",
    config = function()
      require('spectre').setup()
    end
  }

  use {
    "phaazon/hop.nvim",
    as = "hop",
    config = function()
      require("hop").setup {
        keys = "etovxqpdygfblzhckisuran"
      }
    end
  }

  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install"
  }

  use "thinca/vim-template"

  use "toritori0318/vim-redmine"

  use "antoyo/vim-licenses"
end)

