local bin = vim.fn.stdpath("data") .. "/lspinstall/python/node_modules/.bin/pyright-langserver"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("python") end

require'lspconfig'.pyright.setup { cmd = { bin, "--stdio" }, on_attach = require'lsp'.common_on_attach }

