local M

vim.g.loaded_tutor = 1
vim.g.loaded_spec = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_sql_completion = 1
vim.g.loaded_syntax_completion = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.vimsyn_embed = 1

vim.g.netrw_liststyle = 1
vim.g.netrw_banner = 0
vim.g.netrw_sizestyle = "H"
vim.g.netrw_timefmt = "%Y-%m-%d %H:%M:%S"
vim.g.netrw_preview = 1

local packer = nil

local function init()
  if packer == nil then
    packer = require "packer"

    packer.init {
      disable_commands = true,
      display = {
        open_fn = function()
          return require("packer.util").float { border = "none" }
        end,
        prompt_border = "none",
        working_sym = " ",
        error_sym = " ",
        done_sym = " ",
        removed_sym = " ",
        moved_sym = " ",
        header_sym = "─",
      },
    }
  end

  local use = packer.use

  packer.reset()

  -- Packer
  use { "wbthomason/packer.nvim", opt = true }

  -- Performance optimization
  use {
    "lewis6991/impatient.nvim",
    as = "impatient",
  }

  -- Common dependencies
  use {
    { "nvim-lua/plenary.nvim", as = "plenary" },
    { "RishabhRD/popfix" },
  }

  -- Design

  -- Color scheme loader
  use { "rktjmp/lush.nvim", as = "lush" }

  -- Icons
  use { "kyazdani42/nvim-web-devicons", as = "web-devicons" }
  use { "yamatsum/nvim-nonicons", as = "nonicons" }

  -- Bufferline
  use {
    "akinsho/bufferline.nvim",
    as = "bufferline",

    event = "UIEnter",

    config = function()
      require "nvim-bufferline"
    end,

    requires = "nonicons",
  }

  -- Statusline
  use {
    "glepnir/galaxyline.nvim",
    as = "galaxyline",

    event = "BufReadPost",

    config = function()
      require "nvim-galaxyline"
    end,

    requires = "nonicons",
  }

  -- Context menu for bufferline
  use {
    "jbyuki/contextmenu.nvim",
    as = "contextmenu",

    module = "contextmenu",
  }

  -- Scrollbar
  use {
    "dstein64/nvim-scrollview",
    as = "scrollview",

    config = function()
      vim.g.scrollview_nvim_14040_workaround = 1
      vim.g.scrollview_hide_on_intersect = 1
    end,
  }

  -- Notification
  use { "rcarriga/nvim-notify", as = "notify" }

  -- Dashboard
  use {
    "glepnir/dashboard-nvim",
    as = "dashboard",

    cond = function()
      -- Checker from dashboard-nvim code
      return vim.fn.argc() == 0 and vim.fn.line2byte "$" == -1
    end,

    cmd = "Dashboard",

    config = function()
      require "nvim-dashboard"
    end,
  }

  -- Keys
  use {
    "folke/which-key.nvim",
    as = "which-key",

    config = function()
      require "nvim-which-key"
    end,
  }

  -- Motions
  use {
    "phaazon/hop.nvim",
    as = "hop",

    module = "hop",
  }

  -- Editor

  -- MatchParen replace
  use {
    "andymass/vim-matchup",
    as = "matchup",

    event = "BufReadPost",
  }

  -- Text manipulation
  use {
    "t9md/vim-textmanip",
    as = "textmanip",

    keys = "<Plug>(textmanip",

    config = function()
      require "nvim-textmanip"
    end,
  }

  -- Sandwich with quotes
  use {
    "machakann/vim-sandwich",
    as = "sandwich",

    keys = {
      "srb",
      "sdb",
      "sr",
      "sd",
      { "x", "sr" },
      { "x", "sd" },
      { "o", "sa" },
      { "x", "sa" },
      "sa",
    },
  }

  -- Cursor word highlight
  use {
    "RRethy/vim-illuminate",
    as = "illuminate",
  }

  -- Completions and Snippets

  -- Snippet engine
  use {
    "L3MON4D3/LuaSnip",

    event = "InsertEnter",

    config = function()
      require "nvim-luasnip"
    end,

    requires = {
      "rafamadriz/friendly-snippets",

      event = "InsertEnter",
    },
  }

  -- Completion Engine
  use {
    "hrsh7th/nvim-cmp",
    as = "cmp",

    config = function()
      require "nvim-cmp"
    end,

    after = "LuaSnip",

    -- Completion Sources
    requires = {
      {
        "hrsh7th/cmp-nvim-lsp",

        after = "cmp",
      },
      {
        "hrsh7th/cmp-path",

        after = "cmp",
      },
      {
        "hrsh7th/cmp-nvim-lua",

        opt = true,
      },
      {
        "andersevenrud/compe-tmux",
        as = "cmp-tmux",

        branch = "cmp",

        after = "cmp",
      },
      {
        "saadparwaiz1/cmp_luasnip",
        as = "cmp-luasnip",

        after = "cmp",
      },
      {
        "tzachar/cmp-tabnine",

        run = "./install.sh",

        config = function()
          require "nvim-tabnine"
        end,

        after = "cmp",
      },
      {
        "hrsh7th/cmp-emoji",

        opt = true,
      },
    },
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    as = "autopairs",

    config = function()
      require "nvim-autopairs-config"
    end,

    after = "cmp",
  }

  -- Advanced increment
  use {
    "monaqa/dial.nvim",
    as = "dial",

    keys = {
      "<C-a>",
      "<C-x>",
    },
  }

  -- Indent

  -- Indentline
  use {
    "lukas-reineke/indent-blankline.nvim",
    as = "indent-blankline",

    event = "BufReadPost",

    config = function()
      require "nvim-indentline"
    end,
  }

  -- Indent detection
  use {
    "tpope/vim-sleuth",
    as = "sleuth",

    event = "BufReadPost",
  }

  -- Split and Join
  use {
    "AndrewRadev/splitjoin.vim",
    as = "splitjoin",

    keys = {
      "gS",
      "gJ",
    },
  }

  -- Yank and paste

  -- Yank history
  use {
    "bfredl/nvim-miniyank",
    as = "miniyank",

    keys = {
      "<Plug>(miniyank",
    },
  }

  -- Clipboard hijack
  use {
    "kevinhwang91/nvim-hclipboard",
    as = "hclipboard",

    config = function()
      require "nvim-clipboard"
    end,
  }

  -- Highlighted Paste
  use {
    "ayosec/hltermpaste.vim",
    as = "hltermpaste",
  }

  -- Folding

  -- Fold cycling
  use {
    "arecarn/vim-fold-cycle",
    as = "fold-cycle",

    keys = {
      "<BS>",
      "<CR>",
    },
  }

  -- Readable folding format
  use {
    "lambdalisue/readablefold.vim",
    as = "readable-fold",

    event = "BufReadPre",

    config = function()
      vim.g["readablefold#foldspace_char"] = ""
    end,
  }

  -- Color visualizer
  use {
    "RRethy/vim-hexokinase",
    as = "hexokinase",

    run = "make hexokinase",

    event = "BufReadPost",

    config = function()
      require "nvim-hexokinase"
    end,
  }

  -- Zen Mode

  use {
    "folke/zen-mode.nvim",
    as = "zen-mode",

    on_cmd = "ZenMode",

    setup = function()
      vim.cmd [[ packadd twilight ]]
    end,

    config = function()
      require "nvim-zen-mode"
    end,
  }

  -- Shade
  use { "folke/twilight.nvim", as = "twilight" }

  -- Window
  use {
    "t9md/vim-choosewin",
    as = "choosewin",

    keys = "<Plug>(choosewin)",

    config = function()
      vim.g.choosewin_overlay_enable = 1
      vim.g.choosewin_overlay_clear_multibyte = 1
    end,
  }

  -- Comment

  use {
    "b3nj5m1n/kommentary",

    keys = "gc",

    config = function()
      require "nvim-comment"
    end,
  }
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    as = "treesitter-context-commentstring",

    after = {
      "kommentary",
    },
  }

  -- Line comment
  use {
    "kristijanhusak/line-notes.nvim",
    as = "line-notes",

    keys = "gl",

    config = function()
      require "nvim-line-notes"
    end,
  }

  -- Treesitter

  use {
    "nvim-treesitter/nvim-treesitter",
    as = "treesitter",

    branch = "0.5-compat",

    run = ":TSUpdate",

    config = function()
      require "nvim-treesitter-config"
    end,

    -- Treesitter Extensions
    requires = {
      {
        "p00f/nvim-ts-rainbow",
        as = "treesitter-rainbow",
      },
      {
        "windwp/nvim-ts-autotag",
        as = "treesitter-autotag",
      },
      {
        "rohit-px2/nvim-ts-highlightparams",
        as = "treesitter-highlightparams",

        config = function()
          require("nvim-ts-highlightparams").setup()
        end,
      },
      {
        "haringsrob/nvim_context_vt",
        as = "treesitter-context",
      },
      {
        "RRethy/nvim-treesitter-textsubjects",
        as = "treesitter-textsubjects",
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        as = "treesitter-textobjects",
      },
    },
  }

  use {
    "SmiteshP/nvim-gps",
    as = "gps",

    config = function()
      require "nvim-breadcrumb"
    end,
  }

  -- LSP

  use {
    "neovim/nvim-lspconfig",
    as = "lspconfig",

    config = function()
      require "lsp"
      require "lsp.virtual-text"
    end,

    rocks = "lua-toml",

    requires = {
      {
        "williamboman/nvim-lsp-installer",
        as = "lspinstaller",
      },
      {
        "RishabhRD/nvim-lsputils",
        as = "lsputils",
      },
      {
        "ray-x/lsp_signature.nvim",
        as = "lsp-signature",
      },
    },
  }

  -- Error list
  use {
    "folke/trouble.nvim",

    cmd = {
      "Trouble",
      "TroubleToggle",
    },

    config = function()
      require("trouble").setup()
    end,
  }

  -- Formatter
  use {
    "sbdchd/neoformat",

    cmd = "Neoformat",

    config = function()
      require "nvim-formatter"
    end,
  }

  -- Symbols
  use {
    "liuchengxu/vista.vim",
    as = "vista",

    cmd = "Vista",

    config = function()
      require "nvim-vista"
    end,
  }

  -- Lightbulb
  use {
    "kosayoda/nvim-lightbulb",
    as = "lightbulb",

    config = function()
      require "nvim-lightbulb-config"
    end,
  }

  -- Testing

  use {
    "vim-test/vim-test",
    as = "test-lib",

    config = function()
      vim.g["test#strategy"] = "neomake"
    end,
  }

  use {
    "rcarriga/vim-ultest",
    as = "ultest",

    run = ":UpdateRemotePlugins",

    cmd = {
      "Ultest",
      "UltestNearest",
      "UltestDebug",
      "UltestDebugNearest",
      "UltestAttach",
      "UltestSummary",
      "UltestSummaryOpen",
    },

    config = function()
      vim.cmd "packadd neomake"

      require "nvim-ultest"
    end,
  }

  -- Debugging (DAP)
  use {
    "mfussenegger/nvim-dap",
    as = "dap",

    module = "dap",

    config = function()
      vim.cmd [[
        packadd dap-virtual-text
        packadd dap-ui
      ]]

      require "nvim-dap"
      require "nvim-dap.js-ts"
    end,

    requires = {
      -- DAP Extensions
      {
        "theHamsta/nvim-dap-virtual-text",
        as = "dap-virtual-text",

        opt = true,
      },
      {
        "rcarriga/nvim-dap-ui",
        as = "dap-ui",

        opt = true,
      },

      -- Install vscode-cpptools using vimspector
      {
        "puremourning/vimspector",

        run = config_dir .. "/providers/python3/.venv/bin/python3" .. " install_gadget.py --enable-c",

        opt = true,
      },
    },
  }

  -- Debuggers

  -- Neovim lua
  use {
    "jbyuki/one-small-step-for-vimkind",
    as = "nvim-lua-debugger",

    module = "osv",
  }

  -- Python (debugpy)
  use {
    "mfussenegger/nvim-dap-python",
    as = "python-debugger",

    module = "dap-python",
  }

  -- Building
  use {
    "neomake/neomake",

    cmd = {
      "Neomake",
      "NeomakeProject",
    },

    config = function()
      vim.api.nvim_set_keymap("n", "<F5>", "<cmd>NeomakeProject<cr>", { noremap = true })
    end,
  }
  use {
    "johnsyweb/vim-makeshift",
    as = "makeshift",

    after = "neomake",
  }

  -- Tags
  use {
    "jsfaint/gen_tags.vim",
    as = "gen-tags",

    cond = function()
      return vim.fn.executable "ctags" or vim.fn.executable "gtags"
    end,
  }

  -- Search
  use { "kevinhwang91/nvim-hlslens", as = "hlslens" }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    as = "telescope",

    cmd = "Telescope",
    module = "telescope",

    config = function()
      for _, package in ipairs {
        "telescope-media-files",
        "telescope-fzy-native",
        "telescope-dap",
        "telescope-smart-history",
        "project",
      } do
        vim.cmd("packadd " .. package)
      end

      require "nvim-telescope"
    end,

    requires = {
      -- Telescope Extensions
      {
        "nvim-telescope/telescope-media-files.nvim",
        as = "telescope-media-files",

        opt = true,
      },
      {
        "nvim-telescope/telescope-fzy-native.nvim",
        as = "telescope-fzy-native",

        opt = true,
      },
      {
        "nvim-telescope/telescope-dap.nvim",
        as = "telescope-dap",

        opt = true,
      },
      {
        "nvim-telescope/telescope-smart-history.nvim",
        as = "telescope-smart-history",

        opt = true,
      },
      -- Projects
      {
        "ahmedkhalf/project.nvim",
        as = "project",

        opt = true,

        config = function()
          require "nvim-projects"
        end,
      },
    },
  }

  -- Command
  use {
    "gelguy/wilder.nvim",
    as = "wilder",

    run = ":UpdateRemotePlugins",

    config = function()
      vim.fn["wilder#set_option"]("num_workers", 8)
      vim.fn["wilder#enable_cmdline_enter"]()

      require "nvim-wilder"
    end,

    after = {
      "cpsm",
      "fzy-lua-native",
    },

    requires = {
      -- Highlight engines
      {
        "nixprime/cpsm",

        run = "sh -c 'PY3=ON ./install.sh'",

        event = "CmdlineEnter",
      },
      {
        "romgrk/fzy-lua-native",

        run = "make",

        event = "CmdlineEnter",
      },
    },
  }

  use {
    "thinca/vim-ambicmd",
    as = "ambicmd",

    event = "CmdlineEnter",
  }

  -- Files
  use {
    "kyazdani42/nvim-tree.lua",
    as = "file-tree",

    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
    },

    config = function()
      require "nvim-explorer"
    end,
  }

  -- Git

  -- Git hunk signs
  use {
    "lewis6991/gitsigns.nvim",
    as = "gitsigns",

    config = function()
      require "nvim-gitsigns"
    end,
  }

  -- Git manager
  use {
    "TimUntersberger/neogit",

    cmd = "Neogit",
    module = "neogit",

    config = function()
      require "nvim-neogit"
    end,
  }

  -- Diff viewer
  use {
    "sindrets/diffview.nvim",
    as = "diffview",

    after = "neogit",

    config = function()
      require("diffview").setup {}
    end,
  }

  -- Merge resolver
  use {
    "samoshkin/vim-mergetool",

    cmd = {
      "MergetoolToggle",
      "MergetoolStart",
    },

    config = function()
      vim.g.mergetool_layout = "mr"
      vim.g.mergetool_prefer_revision = "local"
    end,
  }

  -- GitHub
  if vim.fn.executable "gh" == 1 then
    use {
      "pwntester/octo.nvim",
      as = "octo",

      cmd = "Octo",

      config = function()
        require "nvim-github"
      end,
    }
  end

  -- Template files
  use {
    "thinca/vim-template",
    as = "template",

    event = {
      "BufReadPost",
      "BufNewFile",
    },

    config = function()
      require "nvim-template"
    end,
  }

  -- Administrator privileges
  use {
    "lambdalisue/suda.vim",
    as = "suda",

    setup = function()
      require "nvim-suda"
    end,
  }

  -- Backup
  use {
    "aiya000/aho-bakaup.vim",
    as = "backup",

    config = function()
      vim.g.bakaup_backup_dir = vim.fn.expand(vim.fn.stdpath "data" .. "/backup")
      vim.g.bakaup_auto_backup = 1
    end,
  }

  -- Containers

  -- Docker manager
  use {
    "kkvh/vim-docker-tools",
    as = "docker-tools",

    cmd = {
      "DockerToolsOpen",
      "DockerToolsToggle",
      "DockerToolsSetHost",
    },
  }

  -- Remote container development
  use {
    "jamestthompson3/nvim-remote-containers",
    as = "remote-containers",

    cmd = {
      "AttachToContainer",
      "BuildImage",
      "StartImage",
    },
  }

  -- Document generation
  use {
    "kkoomen/vim-doge",
    as = "doge",

    run = ":call doge#install()",

    keys = "<leader>*",
    cmd = "DogeGenerate",
  }

  -- Database
  use { "tpope/vim-dadbod", as = "dadbod" }
  use {
    "kristijanhusak/vim-dadbod-completion",
    as = "dadbod-completion",

    opt = true,
  }
  use {
    "kristijanhusak/vim-dadbod-ui",
    as = "dadbod-ui",

    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
    },
  }

  -- SQL
  use {
    "jsborjesson/vim-uppercase-sql",
    as = "sql-uppercase",

    ft = {
      "sql",
      "mysql",
      "plsql",
    },
  }
  use {
    "tami5/sql.nvim",
    as = "sql-lib",

    module = "sql",
  }

  -- Spell
  use {
    "lewis6991/spellsitter.nvim",
    as = "spellsitter",

    config = function()
      require "nvim-spell"
    end,
  }

  -- Wakatime
  use {
    "wakatime/vim-wakatime",
    as = "wakatime",

    cond = function()
      return O.wakatime.enabled
    end,
  }

  -- Redmine
  use {
    "toritori0318/vim-redmine",
    as = "redmine",

    cond = function()
      return O.redmine.enabled
    end,
  }

  -- Jupyter notebook
  use {
    "ahmedkhalf/jupyter-nvim",
    as = "jupyter",

    event = {
      "BufReadPost",
      "BufNewFile",
    },

    config = function()
      require "nvim-jupyter"
    end,
  }

  -- REST client
  use {
    "NTBBloodbath/rest.nvim",
    as = "rest",

    keys = {
      "<Plug>RestNvim",
      "<Plug>RestNvimPreview",
    },
  }

  -- Text manipulation
  use {
    "akinsho/toggleterm.nvim",
    as = "toggleterm",

    cmd = {
      "ToggleTerm",
      "ToggleTermOpenAll",
    },

    config = function()
      require("toggleterm").setup {}
    end,
  }

  -- Package management
  use {
    "vuki656/package-info.nvim",
    as = "npm-info",

    ft = "json",

    config = function()
      require "nvim-package-info"
    end,
  }

  -- Todos
  use {
    "folke/todo-comments.nvim",
    as = "todo-comments",

    cmd = "TodoTrouble",

    config = function()
      require("todo-comments").setup()
    end,
  }

  -- Undos
  use {
    "mbbill/undotree",

    cmd = {
      "UndotreeToggle",
      "UndotreeShow",
    },

    setup = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,

    config = function()
      require "nvim-undotree"
    end,
  }

  -- GUI
  use {
    "thinca/vim-fontzoom",
    as = "fontzoom",

    cond = function()
      return vim.fn.has "gui" == 1
    end,
  }

  -- Discord rich presence
  use {
    "andweeb/presence.nvim",
    as = "presence",

    config = function()
      require "nvim-presence"
    end,
  }

  -- Cheat sheet
  use {
    "sudormrfbin/cheatsheet.nvim",
    as = "cheatsheet",

    cmd = "Cheatsheet",
  }

  -- Editorconfig
  use {
    "editorconfig/editorconfig-vim",
    as = "editorconfig",

    event = "BufReadPre",
  }

  -- Markdown

  -- Markdown previewer
  if vim.fn.executable "yarn" == 1 then
    use {
      "iamcco/markdown-preview.nvim",
      as = "markdown-preview",

      run = "sh -c 'cd app && yarn install'",

      ft = {
        "markdown",
        "pandoc.markdown",
        "rmd",
      },
    }
  end

  -- Jump markdown links
  use {
    "jghauser/follow-md-links.nvim",
    as = "follow-md-links",

    ft = {
      "markdown",
      "pandoc.markdown",
      "rmd",
    },

    config = function()
      require "follow-md-links"
    end,
  }

  -- Auto insert markdown bullets
  use {
    "dkarter/bullets.vim",
    as = "markdown-bullets",

    ft = {
      "markdown",
      "text",
      "gitcommit",
      "scratch",
    },
  }

  -- Tailwind CSS
  use {
    "steelsojka/headwind.nvim",

    ft = {

      "html",
      "pug",
      "vue",
      "javascriptreact",
      "javascript.jsx",
      "typescriptreact",
      "typescript.tsx",
      "ejs",
    },

    config = function()
      require("headwind").setup {
        use_treesitter = true,
      }
    end,
  }

  -- Lua
  use {
    "folke/lua-dev.nvim",
    as = "lua-dev",

    module = "lua-dev",
  }

  -- Rust
  use {
    "simrat39/rust-tools.nvim",
    as = "rust-tools",

    ft = "rust",
  }

  -- Python
  use {
    "raimon49/requirements.txt.vim",
    as = "python-requirements-highlight",

    ft = "requirements",
  }

  -- CSV and TSV
  use {
    "mechatroner/rainbow_csv",

    ft = {
      "csv",
      "csv_pipe",
      "tsv",
    },
  }

  -- Systemd
  use {
    "lilydjwg/vim-systemd-syntax",
    as = "systemd-highlight",

    ft = "systemd",
  }

  -- Sway and i3 configuration file
  use {
    "mboughaba/i3config.vim",

    ft = "i3config",
  }

  -- Log
  use {
    "MTDL9/vim-log-highlighting",
    as = "log-highlight",

    ft = "log",
  }

  -- Solidity
  use {
    "ChristianChiarulli/vim-solidity",
    as = "solidity",

    ft = "solidity",
  }

  -- Color converter
  use {
    "NTBBloodbath/color-converter.nvim",
    as = "color-converter",

    keys = {
      "<Plug>ColorConvertCycle",
      "<Plug>ColorConvertHEX",
      "<Plug>ColorConvertRGB",
      "<Plug>ColorConvertHSL",
    },
  }

  -- Escape string
  use {
    "powerman/vim-plugin-AnsiEsc",
    as = "ansi-escape-highlight",

    event = "BufReadPre",

    config = function()
      vim.g.no_cecutil_maps = 1
    end,
  }
end

M = setmetatable({}, {
  __index = function(_, key)
    init()

    return packer[key]
  end,
})

return M
