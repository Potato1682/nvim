vim.g.dashboard_default_executive = "telescope"

local headers_dir = config_dir .. "/lua/nvim-dashboard/headers/"
local rnd = math.random()

if rnd < 0.075 then
  vim.g.dashboard_preview_command = "cat"
  vim.g.dashboard_preview_file = headers_dir .. "hotoke.cat"
  vim.g.dashboard_preview_file_height = 27
  vim.g.dashboard_preview_pipeline = "lolcat"
  vim.g.dashboard_preview_file_width = 80
elseif rnd < 0.175 then
  vim.g.dashboard_preview_command = "cat"
  vim.g.dashboard_preview_file = headers_dir .. "halflife3.cat"
  vim.g.dashboard_preview_file_height = 16
  vim.g.dashboard_preview_file_width = 80
else
  vim.g.dashboard_custom_header = {
    "                                          iiii",
    "                                         i::::i",
    "                                          iiii",
    "",
    "nnnn  nnnnnnnn vvvvvvv           vvvvvvviiiiiii    mmmmmmm    mmmmmmm",
    "n:::nn::::::::nnv:::::v         v:::::v i:::::i  mm:::::::m  m:::::::mm",
    "n::::::::::::::nnv:::::v       v:::::v   i::::i m::::::::::mm::::::::::m",
    "nn:::::::::::::::nv:::::v     v:::::v    i::::i m::::::::::::::::::::::m",
    "  n:::::nnnn:::::n v:::::v   v:::::v     i::::i m:::::mmm::::::mmm:::::m",
    "  n::::n    n::::n  v:::::v v:::::v      i::::i m::::m   m::::m   m::::m",
    "  n::::n    n::::n   v:::::v:::::v       i::::i m::::m   m::::m   m::::m",
    "  n::::n    n::::n    v:::::::::v        i::::i m::::m   m::::m   m::::m",
    "  n::::n    n::::n     v:::::::v        i::::::im::::m   m::::m   m::::m",
    "  n::::n    n::::n      v:::::v         i::::::im::::m   m::::m   m::::m",
    "  n::::n    n::::n       v:::v          i::::::im::::m   m::::m   m::::m",
    "  nnnnnn    nnnnnn        vvv           iiiiiiiimmmmmm   mmmmmm   mmmmmm",
  }
end

vim.g.dashboard_custom_section = {
  a = {
    description = { "  Find File              SPC f  " },
    command = "Telescope find_files",
  },
  b = {
    description = { "  Recently Used Files    SPC s r" },
    command = "Telescope oldfiles",
  },
  c = {
    description = { "  Load Last Session      SPC S l" },
    command = "SessionLoad",
  },
  d = {
    description = { "  Find Word              SPC s t" },
    command = "Telescope live_grep",
  },
  e = {
    description = { "  Settings                      " },
    command = ":e " .. config_dir .. "/lua/nvim-globals.lua",
  },
  f = {
    description = { "  Neovim Config Files           " },
    command = "lua require('telescope.builtin').find_files({ search_dirs = { '~/.config/nvim' }})",
  },
}
