vim.cmd("set iskeyword+=-")
vim.cmd("set shortmess+=c")
vim.cmd("set inccommand=split")
vim.opt.hidden = true
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"
vim.opt.wrap = O.wrap_lines
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.opt.pumheight = 10
vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = "UTF-8"
vim.opt.cmdheight = 2
vim.cmd("set colorcolumn=99999")
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.conceallevel = 0
vim.opt.ts = 4
vim.opt.sw = 4
vim.opt.sts = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.opt.autoindent = true
vim.opt.number = O.number
vim.opt.relativenumber = O.relative_number
vim.opt.cursorline = true
vim.opt.showtabline = 2
vim.opt.showmode = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.signcolumn = "yes:3"
vim.opt.updatetime = 100
vim.opt.redrawtime = 1500
vim.opt.timeoutlen = O.timeoutlen
vim.opt.ttimeoutlen = 10
vim.opt.clipboard = "unnamedplus"
vim.opt.ruler = true
vim.opt.sh = O.shell
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.virtualedit = "onemore"
vim.opt.showcmd = true
vim.opt.errorbells = false
vim.cmd("set formatoptions-=cro")
vim.opt.autoindent = true
vim.cmd("filetype plugin indent on")
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.wildmenu = true
vim.opt.spell = true

vim.cmd("colorscheme " .. O.colorscheme)

