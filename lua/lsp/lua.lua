local bin = require("lspcontainers").command("sumneko_lua")
local lsp_config = require("lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

require'lspconfig'.sumneko_lua.setup {
  cmd = bin,
  on_attach = lsp_config.common_on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true }, maxPreload = 10000 }
    }
  },
}

require('nlua.lsp.nvim').setup(require("lspconfig"), {
  cmd = bin,
  globals = { "Color", "c", "Group", "g", "s" }
})

