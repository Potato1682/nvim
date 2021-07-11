if vim.g.loaded_java_ftplugin then
  return
end

vim.g.loaded_java_ftplugin = true

if vim.fn.glob(vim.fn.stdpath "data" .. "/lspinstall/jdtls/*") == "" then
  require("lspinstall").install_server "jdtls"
end

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

keymap("la", "<cmd>lua require'jdtls'.code_action()<cr>")
vim.api.nvim_buf_set_keymap(
  0,
  "x",
  "<leader>la",
  "<cmd>lua require'jdtls'.range_code_action()<cr>",
  { silent = true, noremap = true }
)
vkeymap("lA", "<cmd>lua require'jdtls'.code_action(true)<cr>")
keymap("le", "<cmd>lua require'jdtls'.extract_variable()<cr>")
vkeymap("lE", "<cmd>lua require'jdtls'.extract_variable(true)<cr>")
keymap("lc", "<cmd>lua require'jdtls'.extract_constant()<cr>")
vkeymap("lC", "<cmd>lua require'jdtls'.extract_constant(true)<cr>")
vkeymap("lm", "<cmd>lua require'jdtls'.extract_method(true)<cr>")

local modules = require "modules"

modules.define_command("JShell", "lua require'jdtls'.jshell()", { buffer = true })
modules.define_command("UpdateProject", "lua require'jdtls'.update_project_config()", { buffer = true })
modules.define_command("JdtBytecode", "lua require'jdtls'.javap()", { buffer = true })
modules.define_command("JdtJol", "lua require'jdtls'.jol()", { buffer = true })
modules.define_command("Neoformat", "lua vim.lsp.buf.formatting()", { buffer = true })
