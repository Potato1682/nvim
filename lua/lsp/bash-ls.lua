local bin = vim.fn.stdpath("data") .. "/lspinstall/bash/node_modules/.bin/bash-language-server"
local lsp_config = require("lsp")

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("bash") end

require'lspconfig'.bashls.setup { cmd = { bin, "start" }, on_attach = lsp_config.common_on_attach }

