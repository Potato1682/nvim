if vim.g.loaded_sh_ftplugin then
  return
end

vim.g.loaded_sh_ftplugin = true

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

require("lspconfig").bashls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command "bashls",
  capabilities = capabilities,
  on_attach = lsp_config.common_on_attach,
}
