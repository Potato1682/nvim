if vim.fn.has("persistent-undo") then
  local target_path = vim.fn.stdpath("data") .. "/undos/"

  vim.fn.mkdir(target_path, "p", 0700)

  vim.o.undodir = target_path
  vim.o.undofile = true
end

