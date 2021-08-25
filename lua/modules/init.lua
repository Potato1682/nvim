local M = {}

function M.define_command(name, action, option)
  local option_string = ""

  if option.bang then
    option_string = " -bang"
  end

  if option.buffer then
    option_string = option_string .. " -buffer"
  end

  if option.nargs then
    if type(option.nargs) == "number" then
      option_string = option_string .. " -nargs=" .. tostring(option.nargs)
    else
      option_string = option_string .. " -nargs=" .. option.nargs
    end
  end

  if option.complete then
    option_string = option_string .. " -complete=" .. option.complete
  end

  vim.cmd("command!" .. option_string .. " " .. name .. " " .. action)
end

function M.is_lsp_active()
  if next(vim.lsp.get_active_clients()) == nil then
    return false
  end

  return true
end

function M.file_mkdirp()
  local dir = vim.fn.expand "%:p:h"

  if vim.fn.isdirectory(dir) == 0 and dir:match ":" == nil then
    vim.fn.mkdir(dir, "p")
  end
end

return M
