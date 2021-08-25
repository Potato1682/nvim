local M = {}

function M.init()
  vim.opt.guifont = O.font:gsub("%s", [[\ ]])
end

return M
