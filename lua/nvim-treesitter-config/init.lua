require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  },
  indent = { enable = { "javascriptreact", "typescriptreact" }},
  autotag = { enable = true },
  rainbow = { enable = true },
  context_commentstring = { enable = true, config = { javascriptreact = { style_element = '{/*%s*/}' }, typescriptreact = { style_element = '{/*%s*/}' }}}
}

