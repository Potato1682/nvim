if vim.g.loaded_yaml_ftplugin then
  return
end

vim.g.loaded_yaml_ftplugin = true

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

require("lspconfig").yamlls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command "yamlls",
  on_attach = lsp_config.common_on_attach,
  root_dir = vim.loop.cwd,
  capabilities = capabilities,
}
