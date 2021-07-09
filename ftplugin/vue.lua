local lsp_config = require "lsp"
local container = require "lspcontainers"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("lspconfig").vuels.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command "vuels",
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
  vetur = {
    completion = {
      autoImport = true,
      useScaffoldSnippets = true,
    },
    experimental = {
      templateInterPolationService = true,
    },
    format = {
      defualtFormatter = {
        js = "eslint",
        ts = "eslint",
      },
      options = {
        tabSize = vim.opt.tabstop,
        useTabs = not vim.opt.expandtab,
      },
      scriptInitialIndent = O.vue.initial_indent.script,
      styleInitialIndent = O.vue.initial_indent.style,
    },
  },
}
