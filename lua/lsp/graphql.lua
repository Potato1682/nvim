local bin = vim.fn.stdpath("data") .. "/lspinstall/graphql/node_modules/.bin/graphql-lsp"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("graphql") end

require("lspconfig").graphql.setup {
  cmd = { bin, "server", "-m", "stream" }
}

