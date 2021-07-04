vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.opt.updatetime = 100
vim.opt.redrawtime = 1500
vim.opt.timeoutlen = O.timeoutlen
vim.opt.ttimeoutlen = 10

vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "full" }
vim.opt.wildoptions = "pum"

vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1

vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"

vim.opt.wrapscan = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.inccommand = "split"

if O.wrap_lines then
  vim.opt.wrap = true
  vim.opt.whichwrap = "b,s,<,>,[,],h,l"
else
  vim.opt.wrap = false
end

vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = "UTF-8"

vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.shortmess = vim.opt.shortmess._value .. "c"
vim.opt.pumheight = 10
vim.opt.pumblend = 17

vim.opt.winblend = 0
vim.opt.scrolloff = O.scroll.scrolloff
vim.opt.sidescrolloff = O.scroll.sidescrolloff
vim.opt.sidescroll = 1

vim.opt.laststatus = 2

vim.opt.number = O.number
vim.opt.relativenumber = O.relative_number
vim.opt.cursorline = O.cursorline
vim.opt.cursorcolumn = O.cursorcolumn
vim.opt.ruler = true
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes:3"
vim.opt.virtualedit = "onemore"

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.opt.sh = O.shell

vim.opt.belloff = "all"
vim.opt.errorbells = false

vim.opt.foldlevel = 4
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

