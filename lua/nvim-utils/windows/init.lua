local M = {}

function M.win_enter()
  if O.cursorline then
    vim.opt_local.cursorline = true
  end

  if O.cursorcolumn then
    vim.opt_local.cursorcolumn = true
  end

  if vim.opt_local.buftype._value ~= "" then
    return
  end

  if
    vim.tbl_contains(
      { "man", "help", "nvimtree", "dashboard", "NeogitStatus", "terminal", "toggleterm" },
      vim.opt_local.filetype._value
    )
  then
    vim.opt_local.spell = false

    return
  end

  vim.opt.spell = true
  vim.opt.spelllang = "en,cjk"
  require "nvim-spell"
  require("spellsitter").mod_spell_opt()
end

function M.win_leave()
  if O.cursorline then
    vim.opt_local.cursorline = false
  end

  if O.cursorcolumn then
    vim.opt_local.cursorcolumn = false
  end

  if vim.opt_local.buftype._value ~= "" then
    return
  end

  vim.opt.spell = false
end

return M
