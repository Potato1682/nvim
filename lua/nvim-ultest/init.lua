vim.api.nvim_set_keymap("n", "]t", "<Plug>(ultest-next-fail)", {})
vim.api.nvim_set_keymap("n", "[t", "<Plug>(ultest-prev-fail)", {})
vim.api.nvim_set_keymap("n", "<F6>", "<cmd>Ultest<cr>", { noremap = true, silent = true })

vim.g.ultest_use_pty = 1

local icons = require "nvim-nonicons"

vim.g.ultest_pass_sign = icons.get "check-circle"
vim.g.ultest_running_sign = icons.get "sync"
vim.g.ultest_fail_sign = icons.get "x-circle"
