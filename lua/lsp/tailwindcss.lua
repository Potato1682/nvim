local bin = vim.fn.stdpath("data") .. "/lspinstall/tailwindcss/tailwindcss-intellisense/extension/dist/server/tailwindServer.js"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("tailwindcss") end

require"lspconfig".tailwindcss.setup {
  cmd = { "node", bin, "--stdio" }
}

