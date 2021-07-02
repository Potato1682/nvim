local lsp_config = require "lsp"
local container = require "lspcontainers"
local schemas = require "lsp.json.schemas"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require("lspconfig").jsonls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  filetypes = { "json", "jsonc" },
  cmd = container.command "jsonls",
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
  root_dir = vim.loop.cwd,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
      end,
    },
  },
  settings = {
    json = {
      schemas = schemas.schemas,
    },
  },
}
