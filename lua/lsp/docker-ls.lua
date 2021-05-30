require'lspconfig'.dockerls.setup {
  on_attach = require'lsp'.common_on_attach,
  root_dir = vim.loop.cwd
}

