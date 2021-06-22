local bin = vim.fn.stdpath "data" .. "/lspinstall/efm/efm-langserver"

if vim.fn.filereadable(bin) == 0 then
  require("lspinstall").install_server "efm"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require("lspconfig").efm.setup {
  cmd = { bin },
  init_options = { documentFormatting = true },
  capabilities = capabilities,
  filetypes = { "lua" },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      lua = {
        {
          formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb --indent-width=2 --spaces-inside-table-braces",
          formatStdin = true,
        },
      },
    },
  },
}
