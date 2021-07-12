local M = {}

local npairs = require "nvim-autopairs"

function M.repeat_indent(indent_number)
  if not vim.bo.expandtab then
    return npairs.esc(string.rep("<Tab>", indent_number))
  else
    return string.rep(" ", indent_number)
  end
end

function M.get_indents(linenr)
  local indent = require "nvim-treesitter.indent"

  if linenr == nil then
    linenr = vim.api.nvim_win_get_cursor(0)[1]
  end

  local indent_number = indent.get_indent(linenr)

  if indent_number == -1 then
    if vim.opt.cindent._value then
      local c_indent_number = vim.api.nvim_call_function("cindent", { linenr })

      return c_indent_number
    else
      indent_number = vim.api.nvim_call_function("indent", { linenr })

      local cursor = vim.api.nvim_win_get_cursor(0)[1]

      if indent_number == 0 and cursor ~= 1 then
        return M.get_indents(cursor - 1)
      end

      return vim.opt.expandtab._value and vim.opt.shiftwidth._value or 1
    end
  end

  return indent_number
end

function M.smart_indent()
  if vim.fn.getline "." == "" then
    local indents = M.get_indents(vim.api.nvim_win_get_cursor(0)[1])

    return M.repeat_indent(indents)
  end

  return M.repeat_indent(vim.opt.expandtab._value and vim.opt.shiftwidth._value or 1)
end

return M