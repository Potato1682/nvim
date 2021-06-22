local lsp_config = require "lsp"
local bin = vim.fn.stdpath "data"
  .. "/lspinstall/tailwindcss/tailwindcss-intellisense/extension/dist/server/tailwindServer.js"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "tailwindcss"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require("lspconfig").tailwindcss.setup {
  cmd = { "node", bin, "--stdio" },
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
}
