local container = require "lspcontainers"
local lsp_config = require "lsp"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require("lspconfig").pyright.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command "pyright",
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
}
