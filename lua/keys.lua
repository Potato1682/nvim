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
keymap("n", "<leader>q", ":lua require'utils.buffer'.delete_buffer()<CR>", { noremap = true, silent = true })

-- generate documents
keymap("n", "<leader>*", ":DogeGenerate<CR>", { noremap = true, silent = true })

-- open projects
keymap("n", "<leader>p", ":lua require'telescope'.extensions.project.project {}<CR>", { noremap = true, silent = true })

-- Better window movement
keymap("n", "<C-h>", "<C-w>h", { silent = true })
keymap("n", "<C-j>", "<C-w>j", { silent = true })
keymap("n", "<C-k>", "<C-w>k", { silent = true })
keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- Better indenting
keymap("v", "<", "<gv", { noremap = true, silent = true })
keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Tab switch buffer
keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
keymap("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })

-- Move selected line / block of text in visual line
keymap("x", "K", ":move '<-2<CR>gv-gv'", { noremap = true, silent = true })
keymap("x", "J", ":move '>+1<CR>gv-gv'", { noremap = true, silent = true })

-- Resize with arrow keys
vim.cmd [[
  nnoremap <silent> <C-Up>    :resize -2<CR>
  nnoremap <silent> <C-Down>  :resize +2<CR>
  nnoremap <silent> <C-Left>  :vertical resize -2<CR>
  nnoremap <silent> <C-Right> :vertical resize +2<CR>
]]

-- Hop
keymap("n", "$", "<cmd>lua require'hop'.hint_words()<cr>", {})

-- Easy align
keymap("n", "ga", "<Plug>(EasyAlign)", {})
keymap("x", "ga", "<Plug>(EasyAlign)", {})

-- Miniyank
keymap("", "p", "<Plug>(miniyank-autoput)", {})
keymap("", "P", "<Plug>(miniyank-autoPut)", {})

if O.toggle.enabled then
  keymap("n", "<C-s>", "<cmd>lua require'utils.toggle'.toggle()<cr>", { noremap = true })
end

-- Command buffer
keymap(
  "n",
  "q:",
  "<Cmd>lua require'cmdbuf'.split_open(vim.o.cmdwinheight)<CR>",
  { noremap = true }
)

keymap(
  "c",
  "<C-f>",
  "<Cmd>lua require'cmdbuf'.split_open(vim.o.cmdwinheight, { line = vim.fn.getcmdline(), column = vim.fn.getcmdpos() })<CR><C-c>",
  { noremap = true }
)

keymap("n", "Q", "<Nop>", { noremap = true })
keymap("n", "ZZ", "<Nop>", { noremap = true })
keymap("n", "ZQ", "<Nop>", { noremap = true })

keymap("n", "j", "<Plug>(faster_move_j)", { silent = true })
keymap("n", "k", "<Plug>(faster_move_k)", { silent = true })
