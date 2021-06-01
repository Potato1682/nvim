vim.api.nvim_set_keymap("", "n", "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require('hlslens').start()<cr>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "N", "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require('hlslens').start()<cr>",
                        { noremap = true, silent = true })

vim.api.nvim_set_keymap("", "*", "*<cmd>lua require('hlslens').start()<cr>", { noremap = true })
vim.api.nvim_set_keymap("", "#", "#<cmd>lua require('hlslens').start()<cr>", { noremap = true })
vim.api.nvim_set_keymap("", "g*", "g*<cmd>lua require('hlslens').start()<cr>", { noremap = true })
vim.api.nvim_set_keymap("", "g#", "g#<cmd>lua require('hlslens').start()<cr>", { noremap = true })

