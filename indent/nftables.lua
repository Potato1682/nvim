if vim.b.did_indent then
  return
end

vim.opt_local.cindent = true
vim.opt_local.cinoptions = "L0,(0,Ws,J1,j1,+N"
vim.opt_local.cinkeys = "0{,0},!^F,o,O,0[,0]"
vim.opt_local.cinwords = "table,chain,set"
vim.opt_local.lisp = false
vim.opt_local.indentkeys = "0{,0},!^F,o,O,0[,0]"
