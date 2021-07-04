if vim.fn.glob(vim.fn.stdpath "data" .. "/lspinstall/jdtls/*") == "" then
  require("lspinstall").install_server "jdtls"
end

-- treesitter fixes
vim.cmd [[ TSBufEnable highlight ]]
vim.cmd [[ TSBufEnable rainbow ]]
vim.cmd [[ TSBufEnable indent ]]
vim.cmd [[ TSBufEnable autotag ]]
vim.cmd [[ TSBufEnable rainbow ]]
vim.cmd [[ TSBufEnable context_commentstring ]]
vim.cmd [[ TSBufEnable textobjects.swap ]]

require "nvim-dap.java"
require "lsp.java"

local jdtls_ui = require "jdtls.ui"

function jdtls_ui.pick_one_async(items, _, _, cb)
  require("lsputil.codeAction").code_action_handler(nil, nil, items, nil, nil, nil, cb)
end

local function keymap(key, action)
  vim.api.nvim_buf_set_keymap(0, "n", "<leader>" .. key, action, { silent = true, noremap = true })
end

local function vkeymap(key, action)
  vim.api.nvim_buf_set_keymap(0, "v", "<leader>" .. key, action, { silent = true, noremap = true })
end

keymap("la", ":lua require'jdtls'.code_action()<cr>")
vkeymap("lA", ":lua require'jdtls'.code_action(true)<cr>")
keymap("le", ":lua require'jdtls'.extract_variable()<cr>")
vkeymap("lE", ":lua require'jdtls'.extract_variable(true)<cr>")
keymap("lc", ":lua require'jdtls'.extract_constant()<cr>")
vkeymap("lC", ":lua require'jdtls'.extract_constant(true)<cr>")
vkeymap("lm", ":lua require'jdtls'.extract_method(true)<cr>")

local utils = require "utils"

utils.define_command("JShell", "lua require'jdtls'.jshell()", { buffer = true })
utils.define_command("UpdateProject", "lua require'jdtls'.update_project_config()", { buffer = true })
utils.define_command("JdtBytecode", "lua require'jdtls'.javap()", { buffer = true })
utils.define_command("JdtJol", "lua require'jdtls'.jol()", { buffer = true })
utils.define_command("Format", "lua vim.lsp.buf.formatting()", { buffer = true })
