require'lspconfig'.sumneko_lua.setup {
  cmd = { "lua-language-server", "-E", "/usr/share/lua-language-server/main.lua" },
  on_attach = require'lsp'.common_on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
          path = vim.split(package.path, ';')
        },
        diagnostics = {
          globals = { 'vim' }
        },
        workspace = {
          library = {[ vim.fn.expand('$VIMRUNTIME/lua') ] = true, [ vim.fn.expand('$VIMRUNTIME/lua/vim/lsp') ] = true },
          maxPreload = 10000
       }
    }
  }
}

