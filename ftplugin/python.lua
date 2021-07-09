local container = require "lspcontainers"
local lsp_config = require "lsp"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("lspconfig").pyright.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command "pyright",
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
}

local debug_install_dir = vim.fn.stdpath "data" .. "/dapinstall/python/"

if vim.fn.glob(debug_install_dir) == "" then
  require("nvim-dap.install").install(
    "debugpy",
    debug_install_dir,
    [[
    python -m venv debugpy
    debugpy/bin/python -m pip install debugpy
    debugpy/bin/python -m pip install pytest
  ]]
  )
end

local dap = require "dap-python"

dap.setup(debug_install_dir .. "debugpy/bin/python")
dap.test_runner = O.python.test_type
