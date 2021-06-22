local M = {}

function M.define_command(name, action, option)
  local option_string = ""

  if option.bang then
    option_string = " -bang"
  end

  if option.buffer then
    option_string = option_string .. " -buffer"
  end

  vim.cmd("command!" .. option_string .. " " .. name .. " " .. action)
end

function M.is_lsp_active()
  if next(vim.lsp.get_active_clients()) == nil then
    return false
  end

  return true
end

return M

