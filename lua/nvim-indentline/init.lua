vim.g.indent_blankline_buftype_exclude = { 'terminal' }
vim.g.indent_blankline_filetype_exclude = { 'man', 'help', 'nvimtree', 'dashboard', 'packer', 'neogitstatus', 'markdown', 'gesture', 'sagahover' }
vim.g.indent_blankline_char = '▏'
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
    'class', 'return', 'function', 'method', '^if', '^while', 'jsx_element', '^for', '^object', '^table', 'block',
    'arguments', 'if_statement', 'else_clause', 'jsx_element', 'jsx_self_closing_element', 'try_statement',
    'catch_clause', 'import_statement', 'operation_type'
}
vim.g.indent_blankline_space_char = "·"

vim.cmd [[ hi IndentRainbow1 guifg=#be5046 guibg=NONE gui=nocombine ]]
vim.cmd [[ hi IndentRainbow2 guifg=#e5c07b guibg=NONE gui=nocombine ]]
vim.cmd [[ hi IndentRainbow3 guifg=#98c379 guibg=NONE gui=nocombine ]]
vim.cmd [[ hi IndentRainbow4 guifg=#56b6c2 guibg=NONE gui=nocombine ]]
vim.cmd [[ hi IndentRainbow5 guifg=#61afef guibg=NONE gui=nocombine ]]
vim.cmd [[ hi IndentRainbow6 guifg=#c678dd guibg=NONE gui=nocombine ]]

vim.g.indent_blankline_char_highlight_list = {
  "IndentRainbow1",
  "IndentRainbow2",
  "IndentRainbow3",
  "IndentRainbow4",
  "IndentRainbow5",
  "IndentRainbow6"
}

