local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = { "dashboard" },
  auto_close = O.explorer.auto_close,
  open_on_tab = true,
  hijack_cursor = true,
  update_cwd = true,
  lsp_diagnostics = true,

  update_focused_file = {
    enable = true,

    ignore_list = { ".git", "node_modules", ".cache" },
  },

  view = {
    auto_resize = true,

    mappings = {
      custom_only = false,

      list = {
        { key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb "edit" },
        { key = { "<RightMouse>", "<C-]>" }, cb = tree_cb "cd" },
        { key = "v", cb = tree_cb "vsplit" },
        { key = "s", cb = tree_cb "split" },
        { key = "<C-t>", cb = tree_cb "tabnew" },
        { key = "<", cb = tree_cb "prev_sibling" },
        { key = ">", cb = tree_cb "next_sibling" },
        { key = "P", cb = tree_cb "parent_node" },
        { key = "<BS>", cb = tree_cb "close_node" },
        { key = "<S-CR>", cb = tree_cb "close_node" },
        { key = "<Tab>", cb = tree_cb "preview" },
      },
    },
  },
}

vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_respect_buf_cwd = 1

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
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
  lsp = {
    hint = "",
    info = "",
    warning = "",
    error = "",
  },
}

require("nvim-lsp-installer.adapters.nvim-tree").connect()
