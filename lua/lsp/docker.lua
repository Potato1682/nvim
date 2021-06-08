local container = require("lspcontainers")
local lsp_config = require("lsp")

require'lspconfig'.dockerls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command("dockerls"),
  root_dir = vim.loop.cwd,
  on_attach = lsp_config.common_on_attach
}

