if vim.g.loaded_cs_ftplugin then
  return
end

vim.g.loaded_cs_ftplugin = true

local lsp_config = require "lsp"
local mono = vim.fn.stdpath "data" .. "/lspinstall/csharp/omnisharp/bin/mono"
local bin = vim.fn.stdpath "data" .. "/lspinstall/csharp/omnisharp/omnisharp/OmniSharp.exe"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "csharp"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local pid = vim.fn.getpid()

require("lspconfig").omnisharp.setup {
  cmd = { mono, bin, "--languageserver", "--hostPID", tostring(pid) },
  capabilities = capabilities,
  on_attach = lsp_config.common_on_attach,
}
