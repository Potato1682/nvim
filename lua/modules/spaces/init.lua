local M = {}

function M.highlight_japanese_spaces()
  vim.cmd "hi! ExtraWhitespace ctermfg=246 guifg=#7e8294 ctermbg=52 guibg=#b30000 cterm=NONE gui=NONE guisp=NONE"

  vim.cmd [[match ExtraWhitespace /　/]]
end

function M.highlight_trailing_spaces()
  if vim.opt_local.buftype:get() == "nofile" then
    return
  end

  if
    vim.tbl_contains({ "markdown", "pandoc.markdown", "dashboard", "toggleterm", "neogit" }, vim.opt.filetype:get())
  then
    return
  end

  vim.cmd [[match ExtraWhitespace /\s\+\%#\@<!$/]]
end

function M.highlight_insert_trailing_spaces()
  if vim.opt_local.buftype:get() == "nofile" then
    return
  end

  if
    vim.tbl_contains({ "markdown", "pandoc.markdown", "dashboard", "toggleterm", "neogit" }, vim.opt.filetype:get())
  then
    return
  end

  vim.cmd [[match ExtraWhitespace /\s\+$/]]
end

function M.strip_trailing_spaces()
  if vim.opt_local.buftype:get() == "nofile" then
    return
  end

  if
    vim.tbl_contains({ "markdown", "pandoc.markdown", "dashboard", "toggleterm", "neogit" }, vim.opt.filetype:get())
  then
    return
  end

  vim.cmd [[%s/\s\+$//e]]
end

return M
