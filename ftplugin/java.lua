if vim.fn.glob(vim.fn.stdpath("data") .. "/lspinstall/jdtls/eclipse.jdt.ls/launch") == "" then
  require"lspinstall".install_server("jdtls")
end

-- treesitter fixes
vim.cmd [[ TSEnableAll highlight ]]
vim.cmd [[ TSEnableAll rainbow ]]
vim.cmd [[ TSEnableAll indent ]]
vim.cmd [[ TSEnableAll autotag ]]
vim.cmd [[ TSEnableAll rainbow ]]
vim.cmd [[ TSEnableAll context_commentstring ]]
vim.cmd [[ TSEnableAll textobjects.swap ]]

require("nvim-dap.java")
require("lsp.java")

local jdtls_ui = require"jdtls.ui"

function jdtls_ui.pick_one_async(items, _, _, cb)
  require"lsputil.codeAction".code_action_handler(nil, nil, items, nil, nil, nil, cb)
end

local function keymap(key, action)
  vim.api.nvim_set_keymap("n", "<leader>" .. key, action, { noremap = true, silent = true })
end

local function vkeymap(key, action)
  vim.api.nvim_set_keymap("v", "<leader>" .. key, action, { noremap = true, silent = true })
end

keymap("la", ":lua require'jdtls'.code_action()<cr>")
vkeymap("lA", ":lua require'jdtls'.code_action(true)<cr>")
keymap("le", ":lua require'jdtls'.extract_variable()<cr>")
vkeymap("lE", ":lua require'jdtls'.extract_variable(true)<cr>")
keymap("lc", ":lua require'jdtls'.extract_constant()<cr>")
vkeymap("lC", ":lua require'jdtls'.extract_constant(true)<cr>")
vkeymap("lm", ":lua require'jdtls'.extract_method(true)<cr>")

local utils = require("utils")

utils.define_command("Make", "lua require'jdtls'.compile()", { buffer = true })
utils.define_command("JShell", "lua require'jdtls'.jshell()", { buffer = true })
utils.define_command("UpdateProject", "lua require'jdtls'.update_project_config()", { buffer = true })
utils.define_command("JdtBytecode", "lua require'jdtls'.javap()", { buffer = true })
utils.define_command("JdtJol", "lua require'jdtls'.jol()", { buffer = true })

vim.lsp.handlers["textDocument/codeAction"] = require"lsputil.codeAction".code_action_handler
vim.lsp.handlers["textDocument/references"] = require"lsputil.locations".references_handler
vim.lsp.handlers["textDocument/definition"] = require"lsputil.locations".definition_handler
vim.lsp.handlers["textDocument/declaration"] = require"lsputil.locations".declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] = require"lsputil.locations".implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require"lsputil.symbols".document_handler
vim.lsp.handlers["workspace/symbol"] = require"lsputil.symbols".workspace_handler

