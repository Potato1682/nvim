vim.cmd("set iskeyword+=-")
vim.cmd("set shortmess+=c")
vim.cmd("set inccommand=split")
vim.o.hidden = true
vim.o.title = true
vim.o.titlestring = "%<%F%=%l/%L - nvim"
vim.wo.wrap = false
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd("syntax on")
vim.o.pumheight = 10
vim.o.encoding = "UTF-8"
vim.o.fileencoding = "UTF-8"
vim.o.cmdheight = 2
vim.cmd("set colorcolumn=99999")
vim.o.mouse = "a"
vim.o.splitbelow = true
vim.o.splitright = true
if vim.fn.has("termguicolors") then
  vim.o.t_Co = "256"
  vim.o.termguicolors = true
end
vim.o.conceallevel = 0
vim.cmd("set ts=4")
vim.cmd("set sw=4")
vim.cmd("set sts=4")
vim.bo.expandtab = true
vim.bo.smartindent = true
vim.o.smarttab =  true
vim.bo.autoindent = true
vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.cursorline = true
vim.o.showtabline = 2
vim.o.showmode = false
vim.o.backup = false
vim.o.writebackup = false
vim.wo.signcolumn = "yes"
vim.o.updatetime = 300
vim.o.timeoutlen = 100
vim.o.clipboard = "unnamedplus"
vim.o.ruler = true
vim.o.sh = "zsh"
vim.o.wildmenu = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.virtualedit = "onemore"
vim.o.showcmd = true
vim.o.errorbells = false
vim.cmd("set formatoptions-=cro")
vim.bo.autoindent = true
vim.cmd("filetype plugin indent on")

