local bin = vim.fn.stdpath "data" .. "/lspinstall/cpp/clangd/bin/clangd"
local lsp_config = require "lsp"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "cpp"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require("lspconfig").clangd.setup {
  cmd = { bin, "--background-index", "--cross-file-rename" },
  capabilities = capabilities,
  on_attach = lsp_config.common_on_attach,
}
