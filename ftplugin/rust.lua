local container = require "lspcontainers"
local lsp_config = require "lsp"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("lspconfig").rust_analyzer.setup {
  cmd = container.command "rust_analyzer",
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
}

require "nvim-dap.c-cpp-rust"
