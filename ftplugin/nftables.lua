if vim.b.did_ftplugin then
  return
end

vim.b.did_ftplugin = true

vim.opt_local.commentstring = "#%s"
vim.opt_local.formatoptions = vim.opt_local.formatoptions - "t"
vim.opt_local.formatoptions = vim.opt_local.formatoptions + "croqnlj"

vim.opt_local.comments = "b:#"
