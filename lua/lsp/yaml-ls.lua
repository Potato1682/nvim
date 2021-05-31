local bin = vim.fn.stdpath("data") .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("yaml") end

require'lspconfig'.yamlls.setup { cmd = { bin, "--stdio" }, on_attach = require'lsp'.common_on_attach }

