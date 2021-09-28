vim.cmd [[ hi! IndentRainbow1 guifg=#be5046 guibg=NONE gui=nocombine ]]
vim.cmd [[ hi! IndentRainbow2 guifg=#e5c07b guibg=NONE gui=nocombine ]]
vim.cmd [[ hi! IndentRainbow3 guifg=#98c379 guibg=NONE gui=nocombine ]]
vim.cmd [[ hi! IndentRainbow4 guifg=#56b6c2 guibg=NONE gui=nocombine ]]
vim.cmd [[ hi! IndentRainbow5 guifg=#61afef guibg=NONE gui=nocombine ]]
vim.cmd [[ hi! IndentRainbow6 guifg=#c678dd guibg=NONE gui=nocombine ]]

require("indent_blankline").setup {
  char = "▏",
  buftype_exclude = { "terminal", "nofile" },
  filetype_exclude = { "man", "help", "dashboard" },
  bufname_exclude = { [[.*\.py]] },
  disable_with_nolist = true,
  space_char_blankline = " ",

  char_highlight_list = {
    "IndentRainbow1",
    "IndentRainbow2",
    "IndentRainbow3",
    "IndentRainbow4",
    "IndentRainbow5",
    "IndentRainbow6",
  },

  use_treesitter = true,
  show_current_context = true,

  context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
  },
}

vim.cmd [[ hi! IndentBlanklineContextChar guifg=#3d8cf0 guibg=NONE gui=nocombine ]]
