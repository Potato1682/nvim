local container = require("lspcontainers")
local lsp_config = require("lsp")

require"lspconfig".rust_analyzer.setup { cmd = container.command("rust_analyzer"), on_attach = lsp_config.common_on_attach }

