local packer = nil

local function init()
  if packer == nil then
    packer = require "packer"

    packer.init()
  end

  local use = packer.use

  packer.reset()

  use { "wbthomason/packer.nvim", opt = true }

  use "yamatsum/nvim-nonicons"

  use {
    "sainnhe/edge",

    config = function()
      require "colorscheme"
    end,
  }

  use {
    "dstein64/vim-startuptime",

    config = function()
      vim.g.startuptime_tries = 10
    end,
    cmd = "StartupTime",
  }

  use {
    "RRethy/vim-hexokinase",

    config = function()
      require "nvim-hexokinase"
    end,
    run = "make hexokinase",
    event = "BufEnter",
  }

  use "editorconfig/editorconfig-vim"

  use "jbyuki/contextmenu.nvim"

  use {
    "akinsho/nvim-bufferline.lua",

    config = function()
      require "nvim-bufferline"
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
  }

  use {
    "glepnir/galaxyline.nvim",

    config = function()
      require "nvim-galaxyline"
    end,
    requires = {
      "ryanoasis/vim-devicons",
      "kyazdani42/nvim-web-devicons",
      "yamatsum/nvim-nonicons",
    },
  }

  use {
    "kyazdani42/nvim-tree.lua",

    config = function()
      require "nvim-explorer"
    end,
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
    },
  }

  use {
    "nvim-telescope/telescope.nvim",

    config = function()
      require "nvim-telescope"
    end,
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
  }
  use {
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope-dap.nvim",

    requires = { "nvim-telescope/telescope.nvim" },
  }

  use {
    "PHSix/faster.nvim",

    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_j)", { noremap = false, silent = true })
      vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_k)", { noremap = false, silent = true })
    end,
    event = "BufEnter",
  }

  use {
    "glepnir/dashboard-nvim",

    config = function()
      require "nvim-dashboard"
    end,
  }

  use {
    "neovim/nvim-lspconfig",
  }
  use {
    "kabouzeid/nvim-lspinstall",

    as = "lspinstall",
  }
  use {
    "alexaandru/nvim-lspupdate",

    as = "lspupdate",
    cmd = {
      "LspUpdate",
    },
  }
  use {
    "lspcontainers/lspcontainers.nvim",

    as = "lspcontainers",
  }
  use {
    "mhartington/formatter.nvim",

    as = "formatter",
    config = function()
      require "nvim-formatter"
    end,
  }
  use {
    "nvim-lua/lsp-status.nvim",

    as = "lspstatus",
  }
  use "ray-x/lsp_signature.nvim"
  use {
    "kosayoda/nvim-lightbulb",

    config = function()
      require "nvim-lightbulb-config"
    end,
    event = "BufEnter",
  }
  use "RRethy/vim-illuminate"
  use {
    "folke/trouble.nvim",

    as = "trouble",
    config = function()
      require("trouble").setup()
    end,
  }
  use {
    "folke/todo-comments.nvim",

    as = "trouble-todo-comments",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  }
  use {
    "simrat39/symbols-outline.nvim",

    as = "symbols-outline",
    cmd = "SymbolsOutline",
  }

  use {
    "tjdevries/nlua.nvim",

    requires = {
      "nvim-lua/plenary.nvim",
    },
  }
  use {
    "tjdevries/manillua.nvim",

    as = "manillua",
  }

  use {
    "hrsh7th/nvim-compe",

    config = function()
      require "nvim-compe"
    end,
    event = "InsertEnter *",
  }
  use {
    "hrsh7th/vim-vsnip",
    "hrsh7th/vim-vsnip-integ",
    "rafamadriz/friendly-snippets",
  }

  use {
    "RishabhRD/nvim-lsputils",

    requires = {
      "RishabhRD/popfix",
    },
  }

  use {
    "tzachar/compe-tabnine",

    run = "./install.sh",
    event = "InsertEnter *",
    requires = { "hrsh7th/nvim-compe" },
  }

  use {
    "tpope/vim-dadbod",

    as = "dadbod",
    event = "BufEnter",
  }
  use {
    "kristijanhusak/vim-dadbod-completion",
    "krisajenkins/vim-java-sql",
    "kristijanhusak/vim-dadbod-ui",

    config = function()
      require "nvim-dadbod"
    end,
    after = "dadbod",
    requires = { "tpope/vim-dadbod" },
  }

  use {
    "nvim-treesitter/nvim-treesitter",

    run = ":TSUpdate",
    config = function()
      require "nvim-treesitter-config"
    end,
  }
  use {
    "p00f/nvim-ts-rainbow",
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "theHamsta/crazy-node-movement",
    "haringsrob/nvim_context_vt",
  }
  use {
    "mizlan/iswap.nvim",

    config = function()
      require("iswap").setup {
        grey = "disable",
      }
    end,
    cmd = "ISwap",
  }
  use {
    "lewis6991/spellsitter.nvim",

    config = function()
      require("spellsitter").setup {
        hl = "SpellBad",
        captures = { "comment" },
      }
    end,
    event = "BufEnter",
  }

  use {
    "lukas-reineke/indent-blankline.nvim",

    branch = "lua",
    config = function()
      require "nvim-indentline"
    end,
    event = "BufEnter",
  }

  use {
    "lewis6991/gitsigns.nvim",

    config = function()
      require "nvim-gitsigns"
    end,
    event = "BufEnter",
    requires = { "nvim-lua/plenary.nvim" },
  }

  use {
    "kkoomen/vim-doge",

    config = function()
      require "nvim-doge"
    end,
    event = "BufEnter",
    run = ":call doge#install()",
  }

  use "wakatime/vim-wakatime"

  use {
    "folke/which-key.nvim",

    as = "which-key",
    config = function()
      require "nvim-which-key"
    end,
  }

  use "mfussenegger/nvim-dap"
  use {
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",

    requires = { "mfussenegger/nvim-dap" },
  }
  use "mfussenegger/nvim-jdtls"
  use "mfussenegger/nvim-dap-python"
  use "jbyuki/one-small-step-for-vimkind"

  -- Install vscode-cpptools using vimspector
  use {
    "puremourning/vimspector",
    run = "python3 install_gadget.py --enable-c",
    opt = true,
  }

  use {
    "b3nj5m1n/kommentary",

    config = function()
      local config = require "kommentary.config"
      config.configure_language("typescriptreact", {
        hook_function = function()
          require("ts_context_commentstring.internal").update_commentstring()
        end,
      })

      config.configure_language("vue", {
        hook_function = function()
          require("ts_context_commentstring.internal").update_commentstring()
        end,
      })
    end,
    event = "BufEnter",
  }

  use {
    "mbbill/undotree",

    cmd = {
      "UndotreeToggle",
      "UndotreeShow",
    },
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  }

  use {
    "Pocco81/AbbrevMan.nvim",

    config = function()
      require("abbrev-man").setup {
        load_natural_dictionaries_at_startup = true,
        load_programming_dictionaries_at_startup = true,
        natural_dictionaries = {
          ["nt_en"] = {},
        },
        programming_dictionaries = {
          ["pr_py"] = {},
          ["pr_java"] = {},
          ["pr_lua"] = {},
        },
      }
    end,
    event = "InsertEnter *",
  }

  use {
    "windwp/nvim-autopairs",

    config = function()
      require("nvim-autopairs").setup {
        enable_check_bracket_line = false,
      }
      require "nvim-autopairs-config"
    end,
  }
  use "windwp/nvim-autospace"

  use {
    "ahmedkhalf/lsp-rooter.nvim",

    config = function()
      require("lsp-rooter").setup()
    end,
  }

  use {
    "monaqa/dial.nvim",

    config = function()
      require "nvim-dial"
    end,
    event = "BufEnter *",
  }

  use {
    "notomo/gesture.nvim",

    config = function()
      require "nvim-mouse-gesture"
    end,
    keys = "<RightMouse>",
  }

  use {
    "digitaltoad/vim-pug",

    ft = "pug",
  }

  use {
    "folke/zen-mode.nvim",

    config = function()
      require "nvim-zen-mode"
    end,
  }

  use "tjdevries/colorbuddy.nvim"

  use {
    "windwp/nvim-spectre",

    config = function()
      require("spectre").setup()
    end,
  }

  use {
    "phaazon/hop.nvim",

    as = "hop",
    event = "BufEnter",
  }

  use {
    "junegunn/vim-easy-align",

    as = "easyalign",
    config = function()
      vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
      vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
    end,
    event = "BufEnter",
  }

  use {
    "machakann/vim-sandwich",

    as = "sandwich",
  }

  use {
    "kevinhwang91/nvim-hlslens",

    config = function()
      require "nvim-hlslens"
    end,
  }

  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    cmd = {
      "MarkdownPreview",
      "MarkdownPreviewToggle",
    },
    ft = {
      "markdown",
      "pandoc.markdown",
      "rmd",
    },
  }

  use {
    "thinca/vim-template",

    config = function()
      require "nvim-template"
    end,
  }

  use "toritori0318/vim-redmine"

  use "antoyo/vim-licenses"

  use "tpope/vim-repeat"

  use {
    "bfredl/nvim-miniyank",

    config = function()
      vim.api.nvim_set_keymap("", "p", "<Plug>(miniyank-autoput)", { noremap = false, silent = true })
      vim.api.nvim_set_keymap("", "P", "<Plug>(miniyank-autoPut)", { noremap = false, silent = true })
    end,
  }

  use {
    "nacro90/numb.nvim",

    config = function()
      require("numb").setup()
    end,
    event = "CmdlineEnter",
  }

  use {
    "steelsojka/headwind.nvim",

    config = function()
      require("headwind").setup()
    end,
    ft = {
      "html",
      "pug",
      "vue",
      "javascriptreact",
      "typescriptreact",
      "ejs",
    },
  }

  use {
    "dstein64/nvim-scrollview",

    config = function()
      vim.g.scrollview_nvim_14040_workaround = 1
      vim.g.scrollview_hide_on_intersect = 1
    end,
    event = "BufEnter",
  }

  use {
    "akinsho/nvim-toggleterm.lua",

    config = function()
      require("toggleterm").setup {
        open_mapping = [[<C-t>]],
      }
    end,
    cmd = {
      "ToggleTerm",
      "ToggleTermOpenAll",
    },
  }

  use {
    "NTBBloodbath/rest.nvim",

    requires = { "nvim-lua/plenary.nvim" },
    keys = {
      "<Plug>RestNvim",
      "<Plug>RestNvimPreview",
    },
  }

  use {
    "andweeb/presence.nvim",

    config = function()
      require("presence"):setup()
    end,
  }

  use {
    "thinca/vim-fontzoom",

    cond = function()
      return vim.fn.has "gui" == 1
    end,
  }

  use {
    "TimUntersberger/neogit",

    config = function()
      require("neogit").setup {
        integrations = {
          diffview = true,
        },
      }
    end,
    cmd = "Neogit",
  }
  use {
    "sindrets/diffview.nvim",

    config = function()
      require("diffview").setup {}
    end,
  }
  use {
    "samoshkin/vim-mergetool",

    config = function()
      vim.g.mergetool_layout = "mr"
      vim.g.mergetool_prefer_revision = "local"
    end,
    cmd = {
      "MergetoolToggle",
      "MergetoolStart",
    },
  }

  use {
    "notomo/cmdbuf.nvim",

    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "q:",
        "<Cmd>lua require'cmdbuf'.split_open(vim.o.cmdwinheight)<CR>",
        { noremap = true }
      )
      vim.api.nvim_set_keymap(
        "c",
        "<C-f>",
        "<Cmd>lua require'cmdbuf'.split_open(vim.o.cmdwinheight, { line = vim.fn.getcmdline(), column = vim.fn.getcmdpos() })<CR><C-c>",
        { noremap = true }
      )
    end,
  }

  use {
    "AndrewRadev/splitjoin.vim",

    keys = {
      "gS",
      "gJ",
    },
  }

  use {
    "arecarn/vim-fold-cycle",

    keys = {
      "<BS>",
      "<CR>",
    },
  }

  -- Help document
  use {
    "vim-jp/vimdoc-ja",

    disable = not O.japanese,
  }
  -- Typescript
  use {
    "jose-elias-alvarez/null-ls.nvim",

    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    config = function()
      require("null-ls").setup {}
    end,
  }
  use {
    "jose-elias-alvarez/nvim-lsp-ts-utils",

    after = "null-ls.nvim",
  }
  -- Rust
  use {
    "simrat39/rust-tools.nvim",

    ft = "rust",
  }
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()

    return packer[key]
  end,
})

return plugins
