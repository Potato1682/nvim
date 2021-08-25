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
    swap = {
      enable = true,
      swap_next = {
        ["<leader>ys"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>yS"] = "@parameter.outer",
      }
    }
  },
  matchup = { enable = true },
}

require("nvim-ts-highlightparams").setup()
