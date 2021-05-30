set
  \ tabstop=2
  \ softtabstop=2
  \ shiftwidth=2

autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)

