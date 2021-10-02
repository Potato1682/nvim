local icons = require "nvim-nonicons"

require("diffview").setup {
  enhanced_diff_hl = true,
  icons = {
    folder_closed = icons.get "file-directory",
    folder_open = icons.get "file-directory-outline",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
  },
  file_panel = {
    width = 30,
  },
}
