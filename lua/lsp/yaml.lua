local container = require("lspcontainers")
local lsp_config = require("lsp")

require'lspconfig'.yamlls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command("yamlls"),
  on_attach = lsp_config.common_on_attach
}

