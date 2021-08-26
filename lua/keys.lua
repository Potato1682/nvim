local keymap = vim.api.nvim_set_keymap

-- Set leader
if O.leader == " " then
  keymap("n", "<Space>", "", { noremap = true, silent = true })
  vim.g.mapleader = " "
else
  vim.g.mapleader = O.leader
end

vim.g.maplocalleader = O.localleader

-- no hl
keymap("n", "<Leader>h", "<cmd>let @/=''<cr>", { noremap = true, silent = true })

-- explorer
keymap("n", "<Leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })

-- telescope
keymap("n", "<Leader>f", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })

-- dashboard
keymap("n", "<Leader>;", "<cmd>Dashboard<cr>", { noremap = true, silent = true })

-- close buffer
keymap("n", "<leader>q", "<cmd>lua require'modules.buffer'.delete_buffer()<cr>", { noremap = true, silent = true })

-- generate documents
keymap("n", "<leader>*", "<cmd>DogeGenerate<cr>", { noremap = true, silent = true })

-- split
keymap("n", "s", "", { noremap = true })
keymap("n", "ss", "<cmd>split<cr>", { noremap = true })
keymap("n", "sv", "<cmd>vsplit<cr>", { noremap = true })

-- open projects
keymap(
  "n",
  "<leader>p",
  "<cmd>lua require'telescope'.extensions.projects.projects {}<cr>",
  { noremap = true, silent = true }
)

-- Better window movement
keymap("n", "<C-h>", "<C-w>h", { silent = true })
keymap("n", "<C-j>", "<C-w>j", { silent = true })
keymap("n", "<C-k>", "<C-w>k", { silent = true })
keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- Better indenting
keymap("v", "<", "<gv", { noremap = true, silent = true })
keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Buffers
keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true })
keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, silent = true })
keymap("n", "gb", "<cmd>BufferLinePick<cr>", { noremap = true, silent = true })

-- Text manipulation
keymap("x", "H", "<Plug>(textmanip-move-left)", {})
keymap("x", "J", "<Plug>(textmanip-move-down)", {})
keymap("x", "K", "<Plug>(textmanip-move-up)", {})
keymap("x", "L", "<Plug>(textmanip-move-right)", {})
keymap("x", "<Left>", "<Plug>(textmanip-move-left-r)", {})
keymap("x", "<Down>", "<Plug>(textmanip-move-down-r)", {})
keymap("x", "<Up>", "<Plug>(textmanip-move-up-r)", {})
keymap("x", "<Right>", "<Plug>(textmanip-move-right-r)", {})
keymap("n", "<D-d>", "<Plug>(textmanip-duplicate-down)", {})
keymap("x", "<D-d>", "<Plug>(textmanip-duplicate-down)", {})
keymap("n", "<D-D>", "<Plug>(textmanip-duplicate-up)", {})
keymap("x", "<D-D>", "<Plug>(textmanip-duplicate-up)", {})
keymap("n", "<M-d>", "<Plug>(textmanip-duplicate-down)", {})
keymap("x", "<M-d>", "<Plug>(textmanip-duplicate-down)", {})
keymap("n", "<M-D>", "<Plug>(textmanip-duplicate-up)", {})
keymap("x", "<M-D>", "<Plug>(textmanip-duplicate-up)", {})

-- Hop
keymap("n", "$", "<cmd>lua require'hop'.hint_words()<cr>", {})

-- Choose windows
keymap("n", "-", "<Plug>(choosewin)", {})

-- Easy align
keymap("n", "ga", "<Plug>(EasyAlign)", {})
keymap("x", "ga", "<Plug>(EasyAlign)", {})

-- Miniyank
keymap("", "p", "<Plug>(miniyank-autoput)", {})
keymap("", "P", "<Plug>(miniyank-autoPut)", {})

if O.toggle.enabled then
  keymap("n", "<C-s>", "<cmd>lua require'modules.toggle'.toggle()<cr>", { noremap = true })
end

keymap("n", "gR", "<cmd>AnyJump<cr>", { noremap = true })
keymap("x", "gR", "<cmd>AnyJumpVisual<cr>", { noremap = true })

keymap("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", { noremap = true })
keymap("n", "<leader>Sl", "<cmd>SessionLoad<cr>", { noremap = true })

keymap("n", "Q", "<Nop>", { noremap = true })
keymap("n", "ZZ", "<Nop>", { noremap = true })
keymap("n", "ZQ", "<Nop>", { noremap = true })

keymap("n", "j", "<cmd>lua require'modules.movement'.move_j()<cr>", { silent = true })
keymap("n", "k", "<cmd>lua require'modules.movement'.move_k()<cr>", { silent = true })

keymap("n", "W", "<cmd>call v:lua.MJp.jp_movement('nW', v:count1)<cr><esc>", { silent = true })
keymap("o", "W", "<cmd>call v:lua.MJp.jp_movement('oW', v:count1)<cr>", { silent = true })
keymap("x", "W", "<cmd>call v:lua.MJp.jp_movement('xW', v:count1)<cr>", { silent = true })
keymap("n", "B", "<cmd>call v:lua.MJp.jp_movement('nB', v:count1)<cr><esc>", { silent = true })
keymap("o", "B", "<cmd>call v:lua.MJp.jp_movement('oB', v:count1)<cr>", { silent = true })
keymap("x", "B", "<cmd>call v:lua.MJp.jp_movement('xB', v:count1)<cr>", { silent = true })
keymap("n", "E", "<cmd>call v:lua.MJp.jp_movement('nE', v:count1)<cr><esc>", { silent = true })
keymap("o", "E", "<cmd>call v:lua.MJp.jp_movement('oE', v:count1)<cr>", { silent = true })
keymap("x", "E", "<cmd>call v:lua.MJp.jp_movement('xE', v:count1)<cr>", { silent = true })
keymap("o", "iW", "<cmd>call v:lua.MJp.jp_object('o', 'i', v:count1)<cr>", { silent = true })
keymap("x", "iW", "<cmd>call v:lua.MJp.jp_object('x', 'i', v:count1)<cr>", { silent = true })
keymap("o", "aW", "<cmd>call v:lua.MJp.jp_object('o', 'a', v:count1)<cr>", { silent = true })
keymap("x", "aW", "<cmd>call v:lua.MJp.jp_object('x', 'a', v:count1)<cr>", { silent = true })
