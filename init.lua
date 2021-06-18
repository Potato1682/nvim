require("nvim-globals")
require("settings")

vim.cmd [[ command! PackerInstall packadd packer.nvim | lua require"plugins".install() ]]
vim.cmd [[ command! PackerUpdate packadd packer.nvim | lua require"plugins".update() ]]
vim.cmd [[ command! PackerSync packadd packer.nvim | lua require"plugins".sync() ]]
vim.cmd [[ command! PackerClean packadd packer.nvim | lua require"plugins".clean() ]]
vim.cmd [[ command! PackerCompile packadd packer.nvim | lua require"plugins".compile() ]]

if require("first-load")() then
  return
end

require("plugins")

vim.cmd("colorscheme " .. O.colorscheme)

require("keys")
require("providers")
require("events")
require("nvim-undotree")

require("nvim-dap")

require("nvim-lspinstall")

require("lsp")
require("lsp.efm-server")
require("lsp.c-cpp")
require("nvim-dap.lua")
require("lsp.lua")
require("lsp.bash")
require("nvim-dap.js-ts")
require("lsp.js-ts")
require("lsp.json")
require("nvim-dap.python")
require("lsp.python")
require("lsp.yaml")
require("lsp.vim")
require("lsp.docker")
require("lsp.html")
require("lsp.emmet")
require("lsp.css")
require("lsp.tailwindcss")
require("lsp.vue")
require("nvim-dap.java")
require("lsp.java")
require("nvim-dap.c-cpp-rust")
require("lsp.rust")
require("lsp.graphql")
require("nvim-dap.ruby")
require("lsp.ruby")
require("nvim-dap.go")
require("lsp.go")
require("nvim-dap.php")
require("lsp.php")
require("lsp.terraform")
require("lsp.svelte")
require("lsp.virtual-text")

require("colorscheme")

