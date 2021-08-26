vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_quit_on_open = O.explorer.auto_close and 1 or 0
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_auto_ignore_ft = { "dashboard" }
vim.g.nvim_tree_update_cwd = 1
vim.g.nvim_tree_respect_buf_cwd = 1

local tree_cb = require("nvim-tree.config").nvim_tree_callback

vim.g.nvim_tree_bindings = {
  { key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb "edit" },
  { key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb "cd" },
  { key = "v", cb = tree_cb "vsplit" },
  { key = "s", cb = tree_cb "split" },
  { key = "<C-t>", cb = tree_cb "tabnew" },
  { key = "<", cb = tree_cb "prev_sibling" },
  { key = ">", cb = tree_cb "next_sibling" },
  { key = "P", cb = tree_cb "parent_node" },
  { key = "<BS>", cb = tree_cb "close_node" },
  { key = "<S-CR>", cb = tree_cb "close_node" },
  { key = "<Tab>", cb = tree_cb "preview" },
  { key = "K", cb = tree_cb "first_sibling" },
  { key = "J", cb = tree_cb "last_sibling" },
  { key = "I", cb = tree_cb "toggle_ignored" },
  { key = "H", cb = tree_cb "toggle_dotfiles" },
  { key = "R", cb = tree_cb "refresh" },
  { key = "a", cb = tree_cb "create" },
  { key = "d", cb = tree_cb "remove" },
  { key = "r", cb = tree_cb "rename" },
  { key = "<C-r>", cb = tree_cb "full_rename" },
  { key = "x", cb = tree_cb "cut" },
  { key = "c", cb = tree_cb "copy" },
  { key = "p", cb = tree_cb "paste" },
  { key = "y", cb = tree_cb "copy_name" },
  { key = "Y", cb = tree_cb "copy_path" },
  { key = "gy", cb = tree_cb "copy_absolute_path" },
  { key = "-", cb = tree_cb "dir_up" },
  { key = "q", cb = tree_cb "close" },
  { key = "g?", cb = tree_cb "toggle_help" },
}

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "",
    unmerged = "",
    renamed = "➜",
    untracked = "",
    -- ignored = "◌"
  },
  folder = { default = "", open = "", empty = "", empty_open = "", symlink = "" },
  lsp = { hint = "", info = "", warning = "", error = "" },
}

require"nvim-lsp-installer.adapters.nvim-tree".connect()
