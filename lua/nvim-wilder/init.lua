local function keymap(key, action)
	vim.api.nvim_set_keymap("c", key, action, { expr = true })
end

keymap("<Tab>", "wilder#in_context() ? wilder#next() : '\\<Tab>'")
keymap("<S-Tab>", "wilder#in_context() ? wilder#previous() : '\\<S-Tab>'")

keymap("<C-j>", "wilder#in_context() ? wilder#next() : '\\<Tab>'")
keymap("<C-k>", "wilder#in_context() ? wilder#next() : '\\<Tab>'")

keymap("<Down>", "wilder#can_accept_completion() ? wilder#accept_completion() : '\\<Down>'")
keymap("<Up>", "wilder#can_reject_completion() ? wilder#reject_completion() : '\\<Up>'")

local set = vim.fn["wilder#set_option"]

set("modes", {
	"/",
	"?",
	":",
	"substitute",
})

vim.cmd("source " .. vim.fn.stdpath("config") .. "/lua/nvim-wilder/wild.vim")
