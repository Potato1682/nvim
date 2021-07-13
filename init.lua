require "nvim-globals"
require "settings"
require "events"

require "nvim-dashboard"

if require "first-load"() then
  require "plugins"

  vim.fn["dein#remote_plugins"]()

  return
end

require "plugins"

require "colorscheme"

require "nvim-bufferline"
require "nvim-galaxyline"
require "nvim-treesitter-config"
require "nvim-indentline"
require "nvim-template"
require "nvim-lspinstall"

require "modules.japanese"
require "modules.eof"
require "keys"
require "providers"
require "commands"
require "nvim-undotree"

require "lsp"
require "lsp.virtual-text"

require "lsp.js-ts"
require "lsp.emmet"
require "lsp.tailwindcss"
require "lsp.terraform"
