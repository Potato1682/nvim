local binaries = {
  html = vim.fn.stdpath("data") .. "/lspinstall/vscode-servers/node_modules/.bin/vscode-html-language-server",
  css = vim.fn.stdpath("data") .. "/lspinstall/vscode-servers/node_modules/.bin/vscode-css-language-server",
  json = vim.fn.stdpath("data") .. "/lspinstall/vscode-servers/node_modules/.bin/vscode-json-language-server"
}

local needs_install = false

for _, bin in pairs(binaries) do
  if vim.fn.filereadable(bin) ~= 1 then
    needs_install = true
  end
end

if needs_install then require"lspinstall".install_server("vscode-servers") end

local lsp = require("lsp")
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.html.setup {
  cmd = { binaries.html, "--stdio" },
  capabilities = capabilities,
  on_attach = lsp.common_on_attach,
  filetypes = { "html" }
}

lspconfig.cssls.setup {
  cmd = { binaries.css, "--stdio" },
  capabilities = capabilities,
  on_attach = lsp.common_on_attach,
  filetypes = { "css", "scss", "less" }
}

lspconfig.jsonls.setup {
  cmd = { binaries.json, "--stdio" },
  on_attach = lsp.common_on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end
    }
  },
  filetypes = { "json" }
}

