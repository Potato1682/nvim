local bin = vim.fn.stdpath "data" .. "/lspinstall/graphql/node_modules/.bin/graphql-lsp"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "graphql"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require("lspconfig").graphql.setup {
  cmd = { bin, "server", "-m", "stream" },
  capabilities = capabilities,
}
