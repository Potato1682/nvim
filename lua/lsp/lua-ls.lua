local bin = vim.fn.stdpath("data") .. "/lspinstall/lua/sumneko-lua-language-server"

if vim.fn.filereadable(bin) == 0 then require("lspinstall").install_server("lua") end

require'lspconfig'.sumneko_lua.setup {
  cmd = { bin },
  on_attach = require'lsp'.common_on_attach,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true }, maxPreload = 10000 }
    }
  }
}

require('nlua.lsp.nvim').setup(require('lspconfig'), { globals = { "Color", "c", "Group", "g", "s" } })
