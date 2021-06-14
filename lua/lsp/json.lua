local container = require("lspcontainers")

require"lspconfig".jsonls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command("jsonls"),
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

