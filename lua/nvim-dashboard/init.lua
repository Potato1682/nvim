vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_preview_command = "cat"

local headers_dir = vim.fn.stdpath "config" .. "/lua/nvim-dashboard/headers/"
local rnd = math.random()

if rnd < 0.075 then
  vim.g.dashboard_preview_file = headers_dir .. "hotoke.cat"
  vim.g.dashboard_preview_file_height = 27
  vim.g.dashboard_preview_pipeline = "lolcat"
elseif rnd < 0.175 then
  vim.g.dashboard_preview_file = headers_dir .. "halflife3.cat"
  vim.g.dashboard_preview_file_height = 16
else
  vim.g.dashboard_preview_file = headers_dir .. "nvim.cat"
  vim.g.dashboard_preview_file_height = 16
end

vim.g.dashboard_preview_file_width = 80

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
    command = ":e " .. vim.fn.stdpath "config" .. "/lua/nvim-globals.lua",
  },
  f = {
    description = { "  Neovim Config Files           " },
    command = "lua require('telescope.builtin').find_files({ search_dirs = { '~/.config/nvim' }})",
  },
}
