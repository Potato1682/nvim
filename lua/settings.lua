vim.cmd("set iskeyword+=-")
vim.cmd("set shortmess+=c")
vim.cmd("set inccommand=split")
vim.o.hidden = true
vim.o.title = true
vim.o.titlestring = "%<%F%=%l/%L - nvim"
vim.wo.wrap = O.wrap_lines
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
vim.o.smarttab = true
vim.bo.autoindent = true
vim.wo.number = O.number
vim.wo.relativenumber = O.relative_number
vim.wo.cursorline = true
vim.o.showtabline = 2
vim.o.showmode = false
vim.o.backup = false
vim.o.writebackup = false
vim.wo.signcolumn = "yes:3"
vim.o.updatetime = 100
vim.o.redrawtime = 1500
vim.o.timeoutlen = O.timeoutlen
vim.o.ttimeoutlen = 10
vim.o.clipboard = "unnamedplus"
vim.o.ruler = true
vim.o.sh = O.shell
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.virtualedit = "onemore"
vim.o.showcmd = true
vim.o.errorbells = false
vim.cmd("set formatoptions-=cro")
vim.bo.autoindent = true
vim.cmd("filetype plugin indent on")
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.wildmenu = true
vim.o.spell = true

vim.cmd("hi SignColumn ctermbg=235 guibg=#2b2d3a")
vim.cmd("hi GreenSign ctermbg=235 guibg=#2b2d3a")
vim.cmd("hi BlueSign ctermbg=235 guibg=#2b2d3a")
vim.cmd("hi RedSign ctermbg=235 guibg=#2b2d3a")
vim.cmd("hi YellowSign ctermbg=235 guibg=#2b2d3a")

