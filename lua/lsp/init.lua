vim.fn.sign_define("LspDiagnosticsSignError",
                   { texthl = "LspDiagnosticsSignError", text = " ", numhl = "LspDiagnosticsSignError" })
vim.fn.sign_define("LspDiagnosticsSignWarning",
                   { texthl = "LspDiagnosticsSignWarning", text = " ", numhl = "LspDiagnosticsSignWarning" })
vim.fn.sign_define("LspDiagnosticsSignInformation",
                   { texthl = "LspDiagnosticsSignInformation", text = " ", numhl = "LspDiagnosticsSignInformation" })
vim.fn.sign_define("LspDiagnosticsSignHint",
                   { texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" })

local keymap = vim.api.nvim_set_keymap

keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
keymap("n", "<C-p>", ":Lspsaga diagnostic_jump_prev<CR>", { noremap = true, silent = true })
keymap("n", "<C-n>", ":Lspsaga diagnostic_jump_next<CR>", { noremap = true, silent = true })
keymap("n", "<C-f>", ":lua require'lspsaga.action'.smart_scroll_with_saga(1)<CR>", { noremap = true, silent = true })
keymap("n", "<C-b>", ":lua require'lspsaga.action'.smart_scroll_with_saga(-1)<CR>", { noremap = true, silent = true })

vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

vim.lsp.protocol.CompletionItemKind = {
  " (Text)", " (Method)", " (Function)", " (Constructor)", " (Field)", "[] (Variable)", " (Class)",
  " (Interface)", "{} (Module)", " (Property)", " (Unit)", " (Value)", "  (Enum)", " (Keyword)", " (Snippet)",
  " (Color)", " (File)", " (Reference)", " (Folder)", " (EnumMember)", " (Constant)", " (Struct)", " (Event)",
  " (Operator)", " (TypeParameter)"
}

local lsp_config = {}

function lsp_config.common_on_attach(client, _)
  vim.cmd([[ command! -nargs=0 -bang IlluminationDisable call illuminate#disable_illumination(<bang>0) ]])
  require"illuminate".on_attach(client)
end

lsp_config.common_on_attach()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                                                                   { virtual_text = { spacing = 0 }, update_in_insert = true })

return lsp_config

