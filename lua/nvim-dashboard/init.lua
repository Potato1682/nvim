vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_custom_header = {
  "                                          iiii",
  "                                         i::::i",
  "                                          iiii",
  "",
  "nnnn  nnnnnnnn vvvvvvv           vvvvvvviiiiiii    mmmmmmm    mmmmmmm",
  "n:::nn::::::::nnv:::::v         v:::::v i:::::i  mm:::::::m  m:::::::mm" ,
  "n::::::::::::::nnv:::::v       v:::::v   i::::i m::::::::::mm::::::::::m",
  "nn:::::::::::::::nv:::::v     v:::::v    i::::i m::::::::::::::::::::::m",
  "  n:::::nnnn:::::n v:::::v   v:::::v     i::::i m:::::mmm::::::mmm:::::m",
  "  n::::n    n::::n  v:::::v v:::::v      i::::i m::::m   m::::m   m::::m",
  "  n::::n    n::::n   v:::::v:::::v       i::::i m::::m   m::::m   m::::m",
  "  n::::n    n::::n    v:::::::::v        i::::i m::::m   m::::m   m::::m",
  "  n::::n    n::::n     v:::::::v        i::::::im::::m   m::::m   m::::m",
  "  n::::n    n::::n      v:::::v         i::::::im::::m   m::::m   m::::m",
  "  n::::n    n::::n       v:::v          i::::::im::::m   m::::m   m::::m",
  "  nnnnnn    nnnnnn        vvv           iiiiiiiimmmmmm   mmmmmm   mmmmmm"
}

vim.g.dashboard_custom_section = {
  a = {
    description = {"  Find File          "},
    command = "Telescope find_files"
  },
  b = {
    description = {"  Recently Used Files"},
    command = "Telescope oldfiles"
  },
  c = {
    description = {"  Load Last Session  "},
    command = "SessionLoad"
  },
  d = {
    description = {"  Find Word          "},
    command = "Telescope live_grep"
  },
  e = {
    description = {"  Settings           "},
    command = ':e ' .. vim.fn.stdpath("config") .. "/lv-config.lua"
  },
  f = {
    description = {"  Neovim Config Files"},
    command = "lua require('telescope.builtin').find_files({ search_dirs = { '~/.config/nvim' }})"
  }
}

