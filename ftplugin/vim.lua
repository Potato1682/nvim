local lsp_config = require "lsp"
local bin = vim.fn.stdpath "data" .. "/lspinstall/vim/node_modules/.bin/vim-language-server"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "vim"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("lspconfig").vimls.setup {
  cmd = { bin, "--stdio" },
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
}
