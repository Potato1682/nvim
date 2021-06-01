local function format_async(err, _, result, _, bufnr)
  if err ~= nil or result == nil then return end
  if not vim.api.nvim_buf_get_option(bufnr, "modified") then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, bufnr)
    vim.fn.winrestview(view)
    if bufnr == vim.api.nvim_get_current_buf() then vim.api.nvim_command("noautocmd :update") end
  end
end

vim.lsp.handlers["textDocument/formatting"] = format_async

_G.lsp_organize_imports = function()
  local params = { command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) }, title = "" }
  vim.lsp.buf.execute_command(params)
end

local function on_attach(client)
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]], true)
  end
end

local tsserver_bin = vim.fn.stdpath("data") .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server"
local lsp_config = require("lsp")

if vim.fn.filereadable(tsserver_bin) == 0 then require("lspinstall").install_server("typescript") end

require'lspconfig'.tsserver.setup {
  cmd = { tsserver_bin, "--stdio" },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
    lsp_config.common_on_attach()
  end,
  settings = { documentFormatting = false }
}

local diagnosticls_bin = vim.fn.stdpath("data") .. "/lspinstall/diagnosticls/node_modules/.bin/diagnostic-languageserver"

if vim.fn.filereadable(diagnosticls_bin) == 0 then require("lspinstall").install_server("diagnosticls") end

local eslintd_bin = vim.fn.stdpath("data") .. "/lspinstall/eslintd/node_modules/.bin/eslint_d"

require'lspconfig'.diagnosticls.setup {
  cmd = { diagnosticls_bin, "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  on_attach = on_attach,
  init_options = {
    filetypes = {
      javascript = "eslint",
      javascriptreact = "eslint",
      ["javascript.jsx"] = "eslint",
      typescript = "eslint",
      typescriptreact = "eslint",
      ["typescript.tsx"] = "eslint"
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = eslintd_bin,
        rootPatterns = { ".eslintrc", ".eslintrc.js", ".eslintrc.yml", ".eslintrc.json", "package.json" },
        debounce = 100,
        args = { "--stdin", "--stdin-filename=%filepath", "--format=json" },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = { [2] = "error", [1] = "warning" }
      }
    },
    formatters = {
      eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = { ".eslintrc", ".eslintrc.js", ".eslintrc.yml", ".eslintrc.json", "package.json" },
        args = { "--fix", "--fix-to-stdout", "--stdin", "--stdin-filename=%filepath" },
        isStdout = true,
        isStderr = true
      }
    },
    formatFiletypes = {
      javascript = "eslint",
      javascriptreact = "eslint",
      ["javascript.jsx"] = "eslint",
      typescript = "eslint",
      typescriptreact = "eslint",
      ["typescript.tsx"] = "eslint"
    }
  }
}

