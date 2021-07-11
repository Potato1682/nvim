if vim.g.loaded_svelte_ftplugin then
  return
end

vim.g.loaded_svelte_ftplugin = true

local lsp_config = require "lsp"
local container = require "lspcontainers"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("lspconfig").svelte.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command "svelte",
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
}
