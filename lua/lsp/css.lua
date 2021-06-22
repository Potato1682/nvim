local lsp_config = require "lsp"
local bin = vim.fn.stdpath "data" .. "/lspinstall/vscode-servers/node_modules/.bin/vscode-css-language-server"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "vscode-servers"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup {
  cmd = { bin, "--stdio" },
  capabilities = capabilities,
  on_attach = lsp_config.common_on_attach,
  filetypes = { "css", "scss", "less" },
}
