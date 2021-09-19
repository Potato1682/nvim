function _G.P(...)
  local objects = {}

  for i = 1, select("#", ...) do
    local v = select(i, ...)

    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n\n --\n\n"))

  return ...
end

pcall(require, "impatient")

require "nvim-globals"
require "settings"
require "commands"
require "events"
require "keys"

if require "first-load"() then
  return
end

require "providers"

require "plugins"

require "colorscheme"

local ok, notify = pcall(require, "notify")

if ok then
  notify.setup {
    stages = (O.notification or {}).animation_style,

    icons = {
      ERROR = " ",
      WARN = " ",
      INFO = " ",
      DEBUG = " ",
      TRACE = " ",
    },
  }

  vim.notify = notify
end

if vim.fn.executable "ctags" or vim.fn.executable "gtags" then
  require "nvim-tags"
end

if vim.fn.has "gui" then
  require("gui").init()
end

require "modules.japanese"
require "modules.eof"
