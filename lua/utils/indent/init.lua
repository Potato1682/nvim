local M = {}

function M.smart_indent()
  local npairs = require "nvim-autopairs"
  local indent = require "nvim-treesitter.indent"
  local line = vim.fn.getline "."

  if line == "" then
    local indent_number = indent.get_indent(vim.api.nvim_win_get_cursor(0)[1])

    if indent_number == 0 then
      indent_number = 2 * (vim.bo.expandtab and 1 or 2)
    end

    if not vim.bo.expandtab then
      return npairs.esc(string.rep("<Tab>", indent_number))
    end

    return string.rep(" ", indent_number)
  else
    return npairs.esc "<Tab>"
  end
end

return M
