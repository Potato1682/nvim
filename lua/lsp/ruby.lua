local lsp_config = require "lsp"
local bin = vim.fn.stdpath "data" .. "/lspinstall/ruby/solargraph/bin/solargraph"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "ruby"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require("lspconfig").solargraph.setup {
  cmd = { bin, "stdio" },
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
}
