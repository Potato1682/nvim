local bin = vim.fn.stdpath("data") .. "/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js"
local lsp_config = require("lsp")

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("html") end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup { cmd = { "node", bin, "--stdio" }, capabilities = capabilities, on_attach = lsp_config.common_on_attach }

