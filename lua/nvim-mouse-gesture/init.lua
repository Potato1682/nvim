vim.api.nvim_set_keymap("n", "<RightMouse>", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<RightDrag>", "<Cmd>lua require('gesture').draw()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<RightRelease>", "<Cmd>lua require('gesture').finish()<CR>", { noremap = true, silent = true })

local gesture = require('gesture')

gesture.register({ name = "scroll to top", inputs = { gesture.down(), gesture.up() }, action = "normal! gg" })

gesture.register({ name = "scroll to bottom", inputs = { gesture.up(), gesture.down() }, action = "normal! G" })

gesture.register({ name = "next tab", inputs = { gesture.right() }, action = "tabnext" })

gesture.register({ name = "previous tab", inputs = { gesture.left() }, action = "tabprevious" })

gesture.register({
  name = "go back",
  inputs = { gesture.right(), gesture.left() },
  action = [[lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>", true, false, true), "n", true)]]
})

