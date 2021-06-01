local bin = vim.fn.stdpath("data") .. "/lspinstall/python/node_modules/.bin/pyright-langserver"
local lsp_config = require("lsp")

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("python") end

require'lspconfig'.pyright.setup { cmd = { bin, "--stdio" }, on_attach = lsp_config.common_on_attach }

