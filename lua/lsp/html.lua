local container = require("lspcontainers")

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

require"lspconfig".html.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command("html")
}

