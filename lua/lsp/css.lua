local bin = vim.fn.stdpath("data") .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js"
local lsp_config = require("lsp")

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("css") end

local capabilities = vim.lsp.protocol.make_client_capabilities()

require'lspconfig'.cssls.setup {
  cmd = { bin, "--stdio" },
  capabilities = capabilities,
  filetypes = { "css", "sass", "scss", "less" },
  on_attach = lsp_config.common_on_attach,
  settings = { css = { validate = true }, sass = { validate = true }, scss = { validate = true }, less = { validate = true } }
}

