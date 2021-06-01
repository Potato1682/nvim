local bin = vim.fn.stdpath("data") .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server"
local lsp_config = require("lsp")

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("yaml") end

require'lspconfig'.yamlls.setup { cmd = { bin, "--stdio" }, on_attach = lsp_config.common_on_attach }

