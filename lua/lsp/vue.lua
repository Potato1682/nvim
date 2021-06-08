local bin = vim.fn.stdpath("data") .. "/lspinstall/vue/node_modules/.bin/vls"
local lsp_config = require("lsp")

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("vue") end

require"lspconfig".vuels.setup {
  cmd = { bin },
  on_attach = lsp_config.common_on_attach,
  vetur = { completion = { autoImport = true, useScaffoldSnippets = true }, format = { defualtFormatter = { js = "eslint", ts = "eslint" } } }
}

