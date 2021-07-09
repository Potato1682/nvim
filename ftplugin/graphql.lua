local bin = vim.fn.stdpath "data" .. "/lspinstall/graphql/node_modules/.bin/graphql-lsp"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "graphql"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("lspconfig").graphql.setup {
  cmd = { bin, "server", "-m", "stream" },
  capabilities = capabilities,
}
