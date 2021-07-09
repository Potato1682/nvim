local lsp_config = require "lsp"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("lspconfig").dockerls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = {
    "docker",
    "container",
    "run",
    "--interactive",
    "--rm",
    "--volume",
    vim.loop.cwd() .. ":" .. vim.loop.cwd(),
    "rcjsuen/docker-langserver",
    "--stdio",
  },
  root_dir = vim.loop.cwd,
  capabilities = capabilities,
  on_attach = lsp_config.common_on_attach,
}
