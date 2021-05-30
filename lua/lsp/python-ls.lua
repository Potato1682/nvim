require'lspconfig'.pyright.setup {
  cmd = { "/bin/pyright-langserver", "--stdio"},
  on_attach = require'lsp'.common_on_attach,
}

