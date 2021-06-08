local util = require("lspconfig/util")

local bin = vim.fn.stdpath("data") .. "/lspinstall/tailwindcss/tailwindcss-intellisense/extension/dist/server/tailwindServer.js"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("tailwindcss") end

require"lspconfig.configs".tailwindls = {
  default_config = {
    cmd = { "node", bin },
    filetypes = { "html", "svelte", "typescriptreact", "vue" },
    root_dir = util.root_pattern("package.json", ".git")
  },
  docs = { description = [[ ]], default_config = { root_dir = [[ root_pattern("package.json", ".git") ]] } }
}

