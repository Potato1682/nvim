local bin = vim.fn.stdpath("data") .. "/lspinstall/vim/node_modules/.bin/vim-language-server"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("vim") end

require'lspconfig'.vimls.setup { cmd = { bin, "--stdio" }, on_attach = require'lsp'.common_on_attach }

