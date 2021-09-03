local M = {}

function M.format(range, line1, line2, bang, bufnr)
  local lsp_formatted = false

  for _, client in ipairs(vim.lsp.buf_get_clients(bufnr or 0)) do
    local cap = client.resolved_capabilities

    if cap.range_formatting or cap.formatting then
      if range then
        vim.lsp.buf.range_formatting(nil, { line1, 0 }, { line2, 99999999 })
      elseif bang then
        vim.lsp.buf.formatting_sync()
      else
        vim.lsp.buf.formatting()
      end

      lsp_formatted = true
    end
  end

  if not lsp_formatted then
    if vim.fn.exists(":Neoformat") ~= 2 then
      if vim.opt.verbose:get() ~= 0 then
        vim.notify("Formatter plugin unavailable", "error", { title = "formatter" })
      end

      return
    end

    if range then
      vim.cmd(line1 .. "," .. line2 .. "Neoformat")
    else
      vim.cmd [[
        try
          undojoin | Neoformat
        catch /^Vim\%((\a\+)\)\=:E790/
        finally
          silent Neoformat
        endtry
      ]]
    end
  end
end

return M
