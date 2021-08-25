local M = {}

function M.rename()
  return vim.fn.expand "<cword>"
end

function M.workspace_symbol(arglead)
  local result = vim.lsp.buf_request_sync(0, "workspace/symbol", { query = arglead }, 1000) or { {} }
  local symbols = result[1].result or {}

  return vim.tbl_map(function(symbol)
    return symbol.name
  end, symbols)
end

return M
