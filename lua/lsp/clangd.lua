local bin = vim.fn.stdpath("data") .. "/lspinstall/cpp/clangd"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("cpp") end

require'lspconfig'.clangd.setup { cmd = { bin, "--background-index" }, on_attach = require'lsp'.common_on_attach }

