local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    find_command = { "rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
    prompt_prefix = "  ",
    selection_caret = " ❯ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    file_ignore_patterns = {},
    shorten = true,
    winblend = 0,
    border = {},
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

    history = {
      path = data_dir .. "/databases/telescope_history.sqlite3",
      limit = 100,
    },

    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  extensions = {
    media_files = { filetypes = { "png", "webp", "jpg", "jpeg" }, find_cmd = "rg" },
    fzy_native = { override_generic_sorter = true, override_file_sorter = true },
  },
}

require("telescope").load_extension "smart_history"
require("telescope").load_extension "media_files"
require("telescope").load_extension "projects"
require("telescope").load_extension "fzy_native"
require("telescope").load_extension "dap"
