require'lspconfig'.jsonls.setup {
  cmd = {
    "node", "/usr/lib/node_modules/vscode-json-languageserver-bin/jsonServerMain.js",
    "--stdio"
  },
  on_attach = require'lsp'.common_on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
      end
    }
  }
}

