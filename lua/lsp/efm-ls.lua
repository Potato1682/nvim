require"lspconfig".efm.setup {
  init_options = { documentFormatting = true },
  filetypes = { "lua" },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      lua = {
        {
          formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb --indent-width=2 --spaces-inside-table-braces",
          formatStdin = true
        }
      }
    }
  }
}

