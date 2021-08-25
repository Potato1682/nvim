local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.markdown = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-markdown",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  filetype = "markdown",
}

require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
  rainbow = {
    enable = true,
    disable = { "vue", "html" },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-big",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
        ["iC"] = "@comment.inner",
        ["aC"] = "@comment.outer",
        ["ii"] = "@conditional.inner",
        ["ai"] = "@conditional.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>ys"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>yS"] = "@parameter.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    }
  },
  matchup = { enable = true },
}

require("nvim-ts-highlightparams").setup()
