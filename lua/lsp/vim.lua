local bin = vim.fn.stdpath("data") .. "/lspinstall/vim/node_modules/.bin/vim-language-server"
local lsp_config = require("lsp")

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("vim") end

require'lspconfig'.vimls.setup { cmd = { bin, "--stdio" }, on_attach = lsp_config.common_on_attach }

