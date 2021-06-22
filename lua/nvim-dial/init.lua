vim.api.nvim_set_keymap("n", "<C-a>", "<Plug>(dial-increment)", {})
vim.api.nvim_set_keymap("n", "<C-x>", "<Plug>(dial-decrement)", {})
vim.api.nvim_set_keymap("v", "<C-a>", "<Plug>(dial-increment)", {})
vim.api.nvim_set_keymap("v", "<C-x>", "<Plug>(dial-decrement)", {})
vim.api.nvim_set_keymap("v", "g<C-a>", "<Plug>(dial-increment-additional)", {})
vim.api.nvim_set_keymap("v", "g<C-x>", "<Plug>(dial-decrement-additional)", {})

local dial = require "dial"

dial.augends["custom#boolean"] = dial.common.enum_cyclic {
  name = "boolean",
  strlist = { "true", "false" },
}
