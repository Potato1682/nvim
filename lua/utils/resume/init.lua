local M = {}

function M.resume()
  if
    vim.tbl_contains({ "quickfix", "nofile", "help" }, vim.api.nvim_buf_get_option(0, "buftype"))
    or vim.tbl_contains({ "gitcommit", "gitrebase", "svn", "hgcommit" }, vim.api.nvim_buf_get_option(0, "filetype"))
  then
    return
  end

  if vim.fn.line [['"]] > 0 and vim.fn.line [['"]] <= vim.fn.line "$" then
    if vim.fn.line "w$" == vim.fn.line "$" then
      vim.cmd [[normal! g`"]]
    elseif vim.fn.line "$" - vim.fn.line [['"]] > ((vim.fn.line "w$" - vim.fn.line "w0") / 2) - 1 then
      vim.cmd [[normal! g`"zz]]
    else
      vim.cmd [[normal! G'"<C-e>]]
    end
  end

  if vim.fn.foldclosed "." ~= -1 then
    vim.cmd [[normal! zvzz]]
  end
end

return M
