vim.api.nvim_set_keymap("n", "<RightMouse>", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<RightDrag>", "<Cmd>lua require('gesture').draw()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<RightRelease>", "<Cmd>lua require('gesture').finish()<CR>", { noremap = true, silent = true })
