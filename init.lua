require "nvim-globals"
require "settings"

vim.cmd [[ silent! colorschme edge ]]
vim.cmd [[ filetype plugin indent on ]]

if require "first-load"() then
  require "plugins"

  return
end

require "nvim-dashboard"

require "plugins"

require "nvim-bufferline"
require "nvim-galaxyline"
require "nvim-treesitter-config"
require "nvim-indentline"

require "keys"
require "providers"
require "commands"
require "events"
require "nvim-undotree"

require "nvim-dap"

require "lsp"
require "lsp.virtual-text"

require "nvim-dap.js-ts"
require "lsp.js-ts"
require "lsp.emmet"
require "lsp.tailwindcss"
require "nvim-dap.php"
require "lsp.php"
require "lsp.terraform"
