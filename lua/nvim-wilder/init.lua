local function keymap(key, action)
  vim.api.nvim_set_keymap("c", key, action, { expr = true })
end

keymap("<Tab>", "wilder#in_context() ? wilder#next() : '\\<Tab>'")
keymap("<S-Tab>", "wilder#in_context() ? wilder#previous() : '\\<S-Tab>'")

local set = vim.fn["wilder#set_option"]

set("modes", {
  "/",
  "?",
  ":",
})

vim.cmd("source " .. vim.fn.stdpath "config" .. "/lua/nvim-wilder/wild.vim")
