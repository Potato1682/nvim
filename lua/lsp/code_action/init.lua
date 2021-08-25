local M = {}

function M.code_action(range, line1, line2)
  if range then
    vim.lsp.buf.range_code_action(nil, { line1, 0 }, { line2, 99999999 })
  else
    vim.lsp.buf.code_action()
  end
end

return M
