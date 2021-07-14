if vim.g.loaded_nix_ftplugin then
  return
end

vim.g.loaded_nix_ftplugin = true

local lsp_config = require "lsp"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("lspconfig").rnix.setup {
  capabilities = capabilities,
  on_attach = lsp_config.common_on_attach,
}
