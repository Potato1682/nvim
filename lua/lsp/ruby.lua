local bin = vim.fn.stdpath("data") .. "/lspinstall/ruby/solargraph/bin/solargraph"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("ruby") end

require("lspconfig").solargraph.setup {
  cmd = { bin, "stdio" }
}

