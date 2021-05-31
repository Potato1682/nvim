local bin = vim.fn.stdpath("data") .. "/lspinstall/node_modules/.bin/vls"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("vue") end

require"lspconfig".vuels.setup {
  cmd = { bin },
  on_attach = require"lsp".common_on_attach,
  vetur = { completion = { autoImport = true, useScaffoldSnippets = true }, format = { defualtFormatter = { js = "eslint", ts = "eslint" } } }
}

