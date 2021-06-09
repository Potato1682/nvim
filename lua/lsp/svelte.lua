local container = require("lspcontainers")

require"lspconfig".svelte.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command("svelte")
}

