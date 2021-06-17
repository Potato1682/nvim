local lsp_config = require("lsp")
local container = require("lspcontainers")

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require"lspconfig".svelte.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command("svelte"),
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities
}

