function _G.put(...)
  local objects = {}

  for i = 1, select("#", ...) do
    local v = select(i, ...)

    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n --\n"))

  return ...
end

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

local ok, notify = pcall(require, "notify")

if ok then
  vim.notify = notify
end

require "colorscheme"

require "nvim-bufferline"
require "nvim-galaxyline"
require "nvim-treesitter-config"
require "nvim-indentline"
require "nvim-template"

if vim.fn.executable "ctags" or vim.fn.executable "gtags" then
  require "nvim-tags"
end

if vim.fn.has "gui" then
  require("gui").init()
end

require "modules.japanese"
require "modules.eof"
require "keys"
require "providers"
require "commands"
require "nvim-undotree"
require "nvim-clipboard"
require "nvim-projects"
require "nvim-jupyter"
require "nvim-breadcrumb"

require "lsp"
require "lsp.virtual-text"
