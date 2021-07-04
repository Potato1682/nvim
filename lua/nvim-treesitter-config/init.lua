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
  context_commentstring = { enable = true, enable_autocmd = true },
  node_movement = {
    keymaps = {
      move_up = "<a-k>",
      move_down = "<a-j>",
      move_left = "<a-h>",
      move_right = "<a-l>",
      swap_left = "<s-a-h>",
      swap_right = "<s-a-l>",
      select_current_node = "<leader><Cr>",
    },
    swappable_textobjects = { "@function.outer", "@parameter.inner", "@statement.outer" },
    allow_switch_parents = true,
    allow_next_parent = true,
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-big",
    },
  },
}
