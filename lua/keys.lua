local keymap = vim.api.nvim_set_keymap

-- Set leader
if O.leader == " " then
  keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
  vim.g.mapleader = " "
else
  vim.g.mapleader = O.leader
end

-- no hl
keymap("n", "<Leader>h", ":let @/=''<CR>", { noremap = true, silent = true })

-- explorer
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- telescope
keymap("n", "<Leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })

-- dashboard
keymap("n", "<Leader>;", ":Dashboard<CR>", { noremap = true, silent = true })

-- close buffer
keymap("n", "<leader>q", ":lua require'modules.buffer'.delete_buffer()<CR>", { noremap = true, silent = true })

-- generate documents
keymap("n", "<leader>*", ":DogeGenerate<CR>", { noremap = true, silent = true })

-- split
keymap("n", "s", "", { noremap = true })
keymap("n", "ss", "<cmd>split<cr>", { noremap = true })
keymap("n", "sv", "<cmd>vsplit<cr>", { noremap = true })

-- open projects
keymap(
  "n",
  "<leader>p",
  "<cmd>lua require'telescope'.extensions.project.project {}<cr>",
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

-- Tab switch buffer
keymap("n", "<Tab>", "<cmd>bnext<cr>", { noremap = true, silent = true })
keymap("n", "<S-Tab>", "<cmd>bprevious<cr>", { noremap = true, silent = true })

-- Move selected line / block of text in visual line
keymap("x", "K", ":move '<-2<CR>gv-gv'", { noremap = true, silent = true })
keymap("x", "J", ":move '>+1<CR>gv-gv'", { noremap = true, silent = true })

-- Resize with arrow keys
vim.cmd [[
  nnoremap <silent> <Up>    :resize -2<CR>
  nnoremap <silent> <Down>  :resize +2<CR>
  nnoremap <silent> <Left>  :vertical resize -2<CR>
  nnoremap <silent> <Right> :vertical resize +2<CR>
]]

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

keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { noremap = true })
keymap("x", "<leader>la", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", { noremap = true })

keymap("n", "gR", "<cmd>AnyJump<cr>", { noremap = true })
keymap("x", "gR", "<cmd>AnyJumpVisual<cr>", { noremap = true })

keymap("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", { noremap = true })
keymap("n", "<leader>Sl", "<cmd>SessionLoad<cr>", { noremap = true })

keymap("n", "Q", "<Nop>", { noremap = true })
keymap("n", "ZZ", "<Nop>", { noremap = true })
keymap("n", "ZQ", "<Nop>", { noremap = true })

keymap("n", "j", "<cmd>lua require'modules.movement'.move_j()<cr>", { silent = true })
keymap("n", "k", "<cmd>lua require'modules.movement'.move_k()<cr>", { silent = true })

keymap("n", "w", "<cmd>call v:lua.MJp.eol_movement('w', v:count1)<cr>", { silent = true })
keymap("n", "b", "<cmd>call v:lua.MJp.eol_movement('b', v:count1)<cr>", { silent = true })
keymap("n", "e", "<cmd>call v:lua.MJp.eol_movement('e', v:count1)<cr>", { silent = true })
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
