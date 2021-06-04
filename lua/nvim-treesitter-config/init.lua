require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  matchup = { enable = true },
  indent = { enable = { "javascriptreact", "typescriptreact" } },
  autotag = { enable = true },
  rainbow = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = true }
}

