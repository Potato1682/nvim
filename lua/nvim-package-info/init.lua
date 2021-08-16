require("package-info").setup()

vim.api.nvim_set_keymap("n", "<localleader>ns", "<cmd>lua require('package-info').show()<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>nc", "<cmd>lua require('package-info').hide()<cr>", { silent = true, noremap = true })

