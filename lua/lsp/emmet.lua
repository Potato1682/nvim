local bin = vim.fn.stdpath("data") .. "/lspinstall/emmet/node_modules/.bin/emmet-ls"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("emmet") end

local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = { bin, "--stdio" },
      filetypes = { "html", "css", "scss", "vue" },
      root_dir = vim.loop.cwd,
      settings = {}
    }
  }
end

lspconfig.emmet_ls.setup { capabilities = capabilities }

