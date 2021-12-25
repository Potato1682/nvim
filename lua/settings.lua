vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.clipboard = { "unnamedplus" }

vim.opt.shada = "!,'300,<50,@100,s10,h"

vim.opt.updatetime = 100
vim.opt.redrawtime = 1500
vim.opt.timeoutlen = O.timeoutlen
vim.opt.ttimeoutlen = 10

vim.opt.complete = ".,w,b,k,i"

vim.opt.showmode = false
vim.opt.cmdheight = 1
vim.opt.history = 10000

vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"

vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --hidden --vimgrep --smart-case --"

vim.opt.wrapscan = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true

vim.opt.inccommand = ""

vim.opt.textwidth = O.textwidth
vim.opt.colorcolumn = "+1"

if O.wrap_lines then
  vim.opt.wrap = true
  vim.opt.breakat = vim.opt.breakat + [[、。・\ ]]
  vim.opt.breakindent = true

  vim.opt.breakindentopt = {
    shift = 2,
    min = 20,
  }

  vim.opt.showbreak = "⌐"
  vim.opt.cpoptions = vim.opt.cpoptions + "n"
else
  vim.opt.wrap = false
end

vim.opt.whichwrap = "b,s,<,>,[,],h,l"

vim.opt.fileencoding = "UTF-8"
vim.opt.fileformats = { "unix", "mac", "dos" }

vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf = "useopen"

vim.opt.ruler = false

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = -1

vim.opt.shortmess = vim.opt.shortmess + "mcSW"
vim.opt.terse = true

vim.opt.pumheight = 10
vim.opt.pumblend = 17
vim.opt.winblend = 17
vim.opt.winfixheight = true
vim.opt.winfixwidth = true
vim.opt.winaltkeys = "no"

vim.opt.scrolloff = O.scroll.scrolloff
vim.opt.sidescrolloff = O.scroll.sidescrolloff
vim.opt.sidescroll = 1

vim.opt.showtabline = 2

vim.opt.number = O.number
vim.opt.relativenumber = O.relative_number
vim.opt.cursorline = O.cursorline
vim.opt.cursorcolumn = O.cursorcolumn
vim.opt.concealcursor = "nc"
vim.opt.signcolumn = "yes:3"
vim.opt.virtualedit = "onemore"
vim.opt.formatoptions = vim.opt.formatoptions + "1mMn"
vim.opt.matchpairs = vim.opt.matchpairs
  + "「:」,（:）,【:】,『:』,［:］,｛:｝,《:》,〈:〉,‘:’,“:”"

vim.opt.foldlevelstart = 4
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.jumpoptions = "stack"

vim.opt.list = true
vim.opt.listchars = {
  trail = "•",
  eol = "¬",
  precedes = "",
  extends = "",
  nbsp = "•",
}

vim.opt.viewoptions = { "cursor", "folds", "curdir", "slash", "unix" }

vim.opt.synmaxcol = 2500

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.opt.autowrite = true
vim.opt.writeany = true

vim.opt.sessionoptions = {
  "blank",
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "winpos",
  "terminal"
}

vim.opt.sh = O.shell

vim.opt.errorbells = false

vim.opt.secure = true

local undo_dir = O.undo_dir or data_dir .. "/undos"

os.execute("mkdir -p " .. undo_dir)
os.execute("chmod 700 " .. undo_dir)

vim.opt.undodir = undo_dir
vim.opt.undofile = true
