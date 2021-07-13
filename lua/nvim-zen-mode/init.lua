require("zen-mode").setup {
  window = {
    backdrop = 0.95,
    height = 0.9,
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
      foldcolumn = "0", -- disable fold column
    },
  },
  plugins = {
    tmux = { enabled = vim.fn.exists "$TMUX" == 1 },
  },
  on_open = function(_)
    vim.api.nvim_input "<Plug>(ScrollViewDisable)"
  end,
  on_close = function()
    vim.api.nvim_input "<Plug>(ScrollViewEnable)"
  end,
}
