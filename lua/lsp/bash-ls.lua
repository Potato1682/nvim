local container = require("lspcontainers")
local lsp_config = require("lsp")

require'lspconfig'.bashls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command("bashls"),
  on_attach = lsp_config.common_on_attach
}

