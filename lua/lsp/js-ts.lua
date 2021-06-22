local container = require "lspcontainers"
local lsp_config = require "lsp"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require("lspconfig").tsserver.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command "tsserver",
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    lsp_config.common_on_attach(client)

    local ts_utils = require("nvim-lsp-ts-utils")

    ts_utils.setup {
      enable_import_on_completion = true,
      enable_formatting = true,
      formatter = "eslint_d",
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = true,
    }


    ts_utils.setup_client(client)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", { silent = true })
  end,
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  settings = { documentFormatting = false },
}
