vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_preview_command = "cat"

local headers_dir = vim.fn.stdpath "config" .. "/lua/nvim-dashboard/headers/"
local rnd = math.random()

if rnd < 0.075 then
  vim.g.dashboard_preview_file = headers_dir .. "hotoke.cat"
  vim.g.dashboard_preview_file_height = 27
  vim.g.dashboard_preview_pipeline = "lolcat"
else
  vim.g.dashboard_preview_file = headers_dir .. "nvim.cat"
  vim.g.dashboard_preview_file_height = 16
end

vim.g.dashboard_preview_file_width = 80

vim.g.dashboard_custom_section = {
  a = {
    description = { "  Find File          " },
    command = "Telescope find_files",
  },
  b = {
    description = { "  Recently Used Files" },
    command = "Telescope oldfiles",
  },
  c = {
    description = { "  Load Last Session  " },
    command = "SessionLoad",
  },
  d = {
    description = { "  Find Word          " },
    command = "Telescope live_grep",
  },
  e = {
    description = { "  Settings           " },
    command = ":e " .. vim.fn.stdpath "config" .. "/lua/nvim-globals.lua",
  },
  f = {
    description = { "  Neovim Config Files" },
    command = "lua require('telescope.builtin').find_files({ search_dirs = { '~/.config/nvim' }})",
  },
}
