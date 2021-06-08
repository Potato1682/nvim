local bin = vim.fn.stdpath("data") .. "/lspinstall/cpp/clangd/bin/clangd"
local lsp_config = require("lsp")

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("cpp") end

require'lspconfig'.clangd.setup { cmd = { bin, "--background-index" }, on_attach = lsp_config.common_on_attach }

