local Path = require "plenary.path"

if vim.fn.has "persistent-undo" then
  local target_path = data_dir .. "/undos"

  Path:new(target_path):mkdir({ mode = 0700, parents = true, exists_ok = true })

  vim.o.undodir = target_path
  vim.o.undofile = true
end
