local bin = vim.fn.stdpath("data") .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("css") end

local capabilities = vim.lsp.protocol.make_client_capabilities()

require'lspconfig'.cssls.setup {
  cmd = { bin, "--stdio" },
  capabilities = capabilities,
  filetypes = { "css", "sass", "scss", "less" },
  settings = { css = { validate = true }, sass = { validate = true }, scss = { validate = true }, less = { validate = true } }
}

