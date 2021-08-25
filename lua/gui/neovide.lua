local M = {}

function M.init()
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_cursor_antialiasing = true

  vim.g.neovide_cursor_vfx_mode = O.cursor.vfx
end

return M
