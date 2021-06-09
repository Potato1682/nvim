local bin = vim.fn.stdpath("data") .. "/lspinstall/php/intelephense"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("php") end

require"lspconfig".intelephense.setup {
  cmd = { bin, "--stdio" }
}

