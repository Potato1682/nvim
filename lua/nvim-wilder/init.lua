local function keymap(key, action)
  vim.api.nvim_set_keymap("c", key, action, { expr = true })
end

vim.fn["wilder#setup"] {
  modes = {
    "/",
    "?",
    ":",
    "substitute",
  },
  next_key = "<Tab>",
  previous_key = "<S-Tab>",
  accept_key = "<Down>",
  reject_key = "<Up>",
}

keymap("<C-j>", "wilder#in_context() ? wilder#next() : '\\<Tab>'")
keymap("<C-k>", "wilder#in_context() ? wilder#next() : '\\<Tab>'")

vim.cmd("source " .. vim.fn.stdpath "config" .. "/lua/nvim-wilder/wild.vim")
