local M = {}

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.repeat_indent(indent_number)
  local inum = indent_number

  if indent_number == 0 then
    inum = vim.opt_local.expandtab:get() and vim.opt_local.tabstop:get() or 1
  end

  if not vim.bo.expandtab then
    return t(string.rep("<Tab>", inum))
  else
    return string.rep(" ", inum)
  end
end

function M.get_indents(linenr)
  local indent = require "nvim-treesitter.indent"

  if linenr == nil then
    linenr = vim.api.nvim_win_get_cursor(0)[1]
  end

  local indent_number = indent.get_indent(linenr)

  if indent_number == -1 then
    if vim.opt.cindent:get() then
      local c_indent_number = vim.api.nvim_call_function("cindent", { linenr })

      return c_indent_number
    else
      indent_number = vim.api.nvim_call_function("indent", { linenr })

      local cursor = vim.api.nvim_win_get_cursor(0)[1]

      if indent_number == 0 and cursor ~= 1 then
        return M.get_indents(cursor - 1)
      end

      return vim.opt.expandtab:get() and vim.opt.shiftwidth:get() or 1
    end
  end

  return indent_number
end

function M.smart_indent()
  if vim.fn.getline "." == "" then
    local indents = M.get_indents(vim.api.nvim_win_get_cursor(0)[1])

    return M.repeat_indent(indents)
  end

  return M.repeat_indent(vim.opt.expandtab:get() and vim.opt.shiftwidth:get() or 1)
end

return M
