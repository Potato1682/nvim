local bin = vim.fn.stdpath("data") .. "/lspinstall/cpp/clangd/bin/clangd"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("cpp") end

require'lspconfig'.clangd.setup { cmd = { bin, "--background-index" } }

