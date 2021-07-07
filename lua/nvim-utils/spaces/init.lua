local M = {}

function M.highlight_trailing_spaces()
  if vim.tbl_contains({ "markdown", "pandoc.markdown" }, vim.opt.filetype._value) then
    return
  end

  vim.cmd [[match ExtraWhitespace /\s\+\%#\@<!$/]]
end

function M.highlight_insert_trailing_spaces()
  if vim.tbl_contains({ "markdown", "pandoc.markdown" }, vim.opt.filetype._value) then
    return
  end

  vim.cmd [[match ExtraWhitespace /\s\+$/]]
end

function M.strip_trailing_spaces()
  if vim.tbl_contains({ "markdown", "pandoc.markdown" }, vim.opt.filetype._value) then
    return
  end

  vim.cmd [[%s/\s\+$//e]]
end

return M
