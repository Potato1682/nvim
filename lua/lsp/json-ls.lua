local bin = vim.fn.stdpath("data") .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("json") end

require'lspconfig'.jsonls.setup {
  cmd = { "node", bin, "--stdio" },
  on_attach = require'lsp'.common_on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end
    }
  }
}

