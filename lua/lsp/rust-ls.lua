local bin = vim.fn.stdpath("data") .. "/lspinstall/rust/rust-analyzer"
local lsp_config = require("lsp")

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("rust") end

require"lspconfig".rust_analyzer.setup { cmd = { bin }, on_attach = lsp_config.common_on_attach }

