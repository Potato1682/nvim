local virtual_text = {}

virtual_text.show = true

function virtual_text.toggle()
  if virtual_text.show then
    virtual_text.show = false

    vim.lsp.diagnostic.clear(0)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

    print("Diagnostics are hidden")
  else
    virtual_text.show = true

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      }
    )

    print("Diagnostics are visible")
  end
end

return virtual_text

