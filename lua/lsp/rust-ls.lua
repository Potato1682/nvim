local bin = vim.fn.stdpath("data") .. "/lspinstall/rust/rust-analyzer"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("rust") end

require"lspconfig".rust_analyzer.setup { cmd = { bin } }

