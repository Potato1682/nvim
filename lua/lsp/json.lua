local lsp_config = require("lsp")
local container = require("lspcontainers")

require"lspconfig".jsonls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command("jsonls"),
  on_attach = lsp_config.common_on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

