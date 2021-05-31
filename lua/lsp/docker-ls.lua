local bin = vim.fn.stdpath("data") .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("dockerfile") end

require'lspconfig'.dockerls.setup { cmd = { bin, "--stdio" }, on_attach = require'lsp'.common_on_attach, root_dir = vim.loop.cwd }

