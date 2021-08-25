local M = {}

local function check_buf()
  return vim.tbl_contains({ "quickfix", "nofile", "help" }, vim.opt_local.buftype:get())
end

local function check_ft()
  return vim.tbl_contains({ "gitcommit", "gitrebase", "svn", "hgcommit" }, vim.opt_local.filetype:get())
end

local function resume()
  if check_buf() then
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

function M.resume_buf()
  if vim.fn.line "." > 1 or check_buf() then
    return
  end

  resume()
end

function M.resume_ft()
  if check_buf() then
    return
  end

  if check_ft() then
    vim.cmd "normal! gg"

    return
  end

  if vim.fn.line "." > 1 then
    return
  end

  resume()
end

return M
