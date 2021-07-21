vim.b.neoformat_basic_format_trim = 0

if vim.g.loaded_typescript_ftplugin then
  return
end

vim.g.loaded_typescript_ftplugin = true

local container = require "lspcontainers"
local lsp_config = require "lsp"
local lsp = require "lspconfig"

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

lsp.tsserver.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = container.command "tsserver",
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    lsp_config.common_on_attach(client)

    local ts_utils = require "nvim-lsp-ts-utils"

    local eslint_bin

    if vim.fn.executable "./node_modules/.bin/eslint_d" or vim.fn.executable "eslint_d" then
      eslint_bin = "eslint_d"
    elseif vim.fn.executable "./node_modules/.bin/eslint" or vim.fn.executable "eslint" then
      eslint_bin = "eslint"
    end

    local prettier_bin

    if vim.fn.executable "./node_modules/.bin/prettierd" or vim.fn.executable "prettierd" then
      prettier_bin = "prettierd"
    elseif vim.fn.executable "./node_modules/.bin/prettier" or vim.fn.executable "prettier" then
      prettier_bin = "prettier"
    end

    ts_utils.setup {
      enable_import_on_completion = true,

      eslint_bin = eslint_bin,
      eslint_enable_diagnostics = eslint_bin ~= nil,

      formatter = prettier_bin,
      enable_formatting = eslint_bin == nil and prettier_bin ~= nil,

      update_imports_on_move = true,
    }

    ts_utils.setup_client(client)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>TSLspOrganize<CR>", { silent = true, noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", "<cmd>TSLspFixCurrent<CR>", { silent = true, noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>TSLspRenameFile<CR>", { silent = true, noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>TSLspImportAll<CR>", { silent = true, noremap = true })
  end,
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  settings = { documentFormatting = false },
}
