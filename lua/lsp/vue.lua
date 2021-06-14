local lsp_config = require("lsp")
local container = require("lspcontainers")

require"lspconfig".vuels.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command("vuels"),
  on_attach = lsp_config.common_on_attach,
  vetur = { completion = { autoImport = true, useScaffoldSnippets = true }, format = { defualtFormatter = { js = "eslint", ts = "eslint" } } }
}

