vim.fn.sign_define("LspDiagnosticsSignError", { texthl = "LspDiagnosticsSignError", text = " ", numhl = "LspDiagnosticsSignError" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { texthl = "LspDiagnosticsSignWarning", text = " ", numhl = "LspDiagnosticsSignWarning" })
vim.fn.sign_define("LspDiagnosticsSignHint", { texthl = "LspDiagnosticsSignHint", text = " ", numhl = "LspDiagnosticsSignHint" })
vim.fn.sign_define("LspDiagnosticsSignInformation",
                   { texthl = "LspDiagnosticsSignInformation", text = " ", numhl = "LspDiagnosticsSignInformation" })

vim.cmd("hi LspDiagnosticsUnderlineError gui=undercurl guisp=#db4b4b")
vim.cmd("hi LspDiagnosticsUnderlineWarning gui=undercurl guisp=#e0af68")
vim.cmd("hi LspDiagnosticsUnderlineInformation gui=undercurl guisp=#0db9d7")
vim.cmd("hi LspDiagnosticsUnderlineHint gui=undercurl guisp=#10b981")

vim.cmd('nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>')
vim.cmd('nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>')
vim.cmd('nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>')
vim.cmd('nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>')
vim.cmd('nnoremap <silent> ca :Lspsaga code_action<CR>')
vim.cmd('nnoremap <silent> K :Lspsaga hover_doc<CR>')
vim.cmd('nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>')
vim.cmd('nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>')
vim.cmd('nnoremap <silent> <C-f> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>')
vim.cmd('nnoremap <silent> <C-b> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>')
vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

vim.cmd("autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)")
vim.cmd("autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)")
vim.cmd("autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 100)")
vim.cmd("autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 100)")

local function documentHighlight(client, _)
  if client and client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

vim.lsp.protocol.CompletionItemKind = {
  "   (Text)", "   (Method)", "   (Function)", "   (Constructor)", "   (Field)", "[] (Variable)", "   (Class)",
  "   (Interface)", "   (Module)", " 襁 (Property)", "   (Unit)", "   (Value)", "   (Enum)", "   (Keyword)", "   (Snippet)",
  "   (Color)", "   (File)", " ﬌  (Reference)", "   (Folder)", "   (EnumMember)", "   (Constant)", "   (Struct)", "   (Event)",
  " ±  (Operator)", "<> (TypeParameter)"
}

local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
  documentHighlight(client, bufnr)
  require"lsp_signature".on_attach { bind = true, hint_enable = true, floating_window = true }
end

lsp_config.common_on_attach()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = { prefix = "", spacing = 0 },
  signs = false,
  update_in_insert = true
})

return lsp_config

