local lsp_config = require "lsp"
local container = require "lspcontainers"

local lsp = require "lspconfig"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

lsp.terraformls.setup {
  cmd = container.command "terraformls",
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
  filetypes = { "hcl", "tf", "terraform", "tfvars" },
}

-- from docker image
lsp.tflint.setup {
  cmd = {
    "docker",
    "container",
    "run",
    "--interactive",
    "--rm",
    "--volume",
    vim.fn.getcwd() .. ":/data",
    "--image",
    "wata727/tflint",
    "--langserver",
  },
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
}
